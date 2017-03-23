aha-luminate
============

The framework used on American Heart Association's Luminate Online web properties.

Using Grunt
-----------

Before getting started using Grunt, you'll need to install [Node.js](https://nodejs.org). Once you have Node installed, you'll need to install the project 
dependencies:

```
npm install
```

If you are on a Mac and do not have root administrator permissions, you may need to use sudo:

```
sudo npm install
```

With the dependencies installed, you can run the default dev tasks:

```
grunt
```

The dev task will connect to a web server at http://localhost:8000, and run a watch task in the background until you exit.

Generally, you should not need to run the build task locally, as this is run for you by Deploybot whenever you commit a change. If for any reason you do 
need to rebuild the entire codebase, however, you can:

```
grunt build
```

Note that because the build task involves things like minifying many large image files, it may take a long time to complete, especially on Windows. Only 
run the build task if you're sure you need to.

Developing Locally
------------------

When developing locally, you can use an HTTP proxy tool to reroute requests to the aha-luminate directory on the Luminate Online filesystem to your 
machine. One simple tool available for both Windows and Mac is [Fiddler for Chrome](https://chrome.google.com/webstore/detail/fiddler/hkknfnifmbannmgkdliadghepbneplka?hl=en). With the Fiddler extension, you can add an Auto Response rule to replace the String "http://heartdev.convio.net/aha-luminate/" with the Path "http://localhost:8000/".