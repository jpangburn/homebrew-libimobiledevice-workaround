# libimobiledevice-workaround
As of Nov 15, 2021, libimobiledevice has a libimobiledevice-glue project with no homebrew formula, which breaks building HEAD versions of their projects (and on projects that depend on their projects like ios-webkit-debug-proxy).  This repository is a Homebrew tap to workaround this problem temporarily.

## The Problem
Before sometime recently, you could do stuff like:
`brew install --HEAD libusbmuxd`

This would install the HEAD version of libusbmuxd, which resolved some problems for some people (like me).  I used this also for libimobiledevice and ideviceinstaller.  What happened is they created a libimobiledevice-glue repository, refactored some code in there (a great idea), but just haven't had time yet to fix their Homebrew formulae for the main projects to rely on the library code in this new repository.

We all understand, they're super busy and contributing a great project so no one is complaining :-) and everyone appreciates their hard work.

## This solution
It appears I'm not alone with this problem, and other people need fixes in the HEAD versions of these projects- BUT they want to use Homebrew so the update process is easy.  Who wants to keep downloading code and building it when you need to update?  That's what a package manager is for.

So this stopgap repository is born to workaround the problem until those generous folks have time to update their Homebrew formulae.

## How to use it???
All you have to do is the following:
```
brew tap jpangburn/libimobiledevice-workaround
```
This gives your Homebrew installation access to this tap (that command actually is a shortcut to tap this repository `jpangburn/homebrew-libimobiledevice-workaround`).  Then use my `*-head` versions of those projects after uninstalling any original versions you have have around e.g. `brew uninstall libusbmuxd`, `brew uninstall libimobiledevice`, etc.

```
brew install --HEAD libusbmuxd-head
brew install --HEAD libimobiledevice-head
brew install --HEAD ideviceinstaller-head
brew install --HEAD ios-webkit-debug-proxy-head
```

These are HEAD only formulae, so they'll tell you if you forget `--HEAD`.

## Cleanup
Whenever the libimobiledevice maintainers are able to fix their formulae, you should get rid of mine and use theirs.  To do that:

```
brew uninstall ios-webkit-debug-proxy-head
brew uninstall libusbmuxd-head
brew uninstall libimobiledevice-head
brew uninstall ideviceinstaller-head
brew uninstall libimobiledevice-glue-head
brew untap jpangburn/libimobiledevice-workaround
```