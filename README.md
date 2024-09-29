# System Bootstrapper

This is a system boostrapper for Buddy Lindsey, Jr. It is not meant to be universal to everyone.

If you want to take inspiration from it and creat your own then cool, I might use it if it accomplishes the same goals.

## Goals

1. Get as close as I can to a single run install command of everything
2. Support different install paths for different OS's I use
3. Only install things for the environments I use
4. Keep as much as I can in seperate files to for easy additions and updates

Ultimately, I want this to evolve over the next 10 years to get better and better so when startup a new system I can run this and within 30 minutes everything is mostly how I want it.

## Package Manager vs not

One of the things about this setup is I am choosing the apps I want to update via package manager or manually. For most of my command line applications I am chooseing to programatically get the latest version and force an update and not rely on a repository. For other things I am relying on the apt repository in ubuntu.

This all falls away with arch as arch packages are updated regularly so I will opt more for the package manager route.
