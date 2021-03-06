# Mars 

Mars is a sample Rails application that maps resources to XMPP PubSub nodes
rather than HTTP URLs.

REST over XMPP, as it were.

## Getting Started

You'll need a pair of XMPP servers running--`xmpp.local` is assumed to accept
client connections, have a jid _client@xmpp.local_ registered, and be able to
connect to `pubsub.local`. `pubsub.local` is assumed to accept component
connections with the secret _secret_ and be able to connect to `xmpp.local`.

I run a pair of ejabberd-2.0.2 servers: `xmpp.local` runs in Mac OS X,
`pubsub.local` runs inside an Ubuntu VM via VMware Fusion configured with
`avahi-daemon` for ZeroConf goodness.

In addition, some functionality may depend on unreleased versions of
`switchboard` and `xmpp4r`. To develop against trunk versions, clone both
projects above `mars` and set:

    RUBYLIB=../xmpp4r/lib/:../switchboard/lib/

Install dependencies:

    $ sudo gem install mojodna-switchboard -s http://gems.github.com

Initialize submodules:

    $ git submodule update --init

Initialize the database:

    $ rake db:migrate

Configure _dovetail_ to connect to your component-enabled server by editing
`vendor/plugins/dovetail/lib/dovetail.rb`.

Start it up:

    $ script/runner vendor/plugins/dovetail/bin/dovetail

Publish a new item:

    $ echo "<post><body>Post Body</body><title>Post Title</title></post>" | \
        switchboard --jid client@xmpp.local --password pa55word \
        pubsub --server pubsub.local --node "/posts" publish

Update an existing item:

    $ echo "<post><body>New body</body><title>Post Title</title</post>" | \
        switchboard --jid client@xmpp.local --password pa55word \
        pubsub --server pubsub.local --node "/posts" publish --item-id 1

Retrieve all Posts:

    $ switchboard --jid client@xmpp.local --password pa55word \
        pubsub --server pubsub.local --node "/posts" items

Retrieve a single Post:

    $ switchboard --jid client@xmpp.local --password pa55word \
        pubsub --server pubsub.local --node "/posts/1" items

Delete (retract) a single Post:

    $ switchboard --jid client@xmpp.local --password pa55word \
        pubsub --server pubsub.local --node "/posts" \
        retract --item-id 1

_**Note**: This could also be mapped as a `purge` without item ids, but is not
currently._
