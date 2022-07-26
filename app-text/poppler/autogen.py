#!/usr/bin/env python3

import json
import re
import glob
import os
from enum import Enum

github_user = "freedesktop"
github_repo = "poppler"

STABLE_VERSION = "22.04.0"

async def generate(hub, **pkginfo):
	matcher = hub.pkgtools.github.RegexMatcher(regex=hub.pkgtools.github.TagVersionMatch.GRABBY)
	tags = await hub.pkgtools.fetch.get_page(f"https://api.github.com/repos/{github_user}/{github_repo}/tags", is_json=True)
	versions = list(hub.pkgtools.github.iter_tag_versions(tags, matcher=matcher))
	latest, tag_data = await hub.pkgtools.github.latest_tag_version(hub, github_user, github_repo, tags, matcher=matcher)

	# Generate an ebuild for the stable version
	await generate_ebuild(hub, tags, stable=True, matcher=matcher, **pkginfo)

	# Now, generate an ebuild for the latest version
	if latest != STABLE_VERSION:
		await generate_ebuild(hub, tags, stable=False, matcher=matcher, **pkginfo)


async def generate_ebuild(hub, tags, stable=True, matcher=None, **pkginfo):
	select = None
	if stable:
		select = f"poppler-{STABLE_VERSION}"

	newpkginfo = await hub.pkgtools.github.tag_gen(
		hub,
		github_user,
		github_repo,
		tag_data=tags,
		select=select,
		matcher=matcher
	)
	if newpkginfo is None:
		hub.pkgtools.model.log.warning(f"No poppler version found: {select}")
		return
	pkginfo.update(newpkginfo)

	artifact = pkginfo["artifacts"][0]
	await artifact.fetch()
	artifact.extract()
	# needed for subslot changes in the future
	cmake_file = open(
		glob.glob(os.path.join(artifact.extract_path, f"{github_user}-{github_repo}-*", "CMakeLists.txt"))[0]
	).read()
	soversion = re.search("SOVERSION ([0-9]+)", cmake_file)
	subslot = soversion.group(1)
	template_args = dict(github_user=github_user, github_repo=github_repo, subslot=subslot, stable=stable)
	artifact.cleanup()

	ebuild = hub.pkgtools.ebuild.BreezyBuild(
		**pkginfo,
		**template_args,
	)
	ebuild.push()

# vim: ts=4 sw=4 noet
