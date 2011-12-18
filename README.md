# Loudmouth #

Growl notification architecture for distributed Git teams.

In plain english: Loudmouth lets you have Growl notifications on your desktop when someone pushes a commit on a project you're working on. It can be installed as a system wide service and can be configured with a `.loudmouth` file inside your home directory.

## Loudmouth server ##

The server component is a Sinatra/MySql/Redis app that works in a pretty simple way, following a pubsub architecture where it receives pings from post-commit hooks on Github and publishes the git log for the same commit on another channel.

By listening only to certain channels, you end up having only the stream of information you want.
