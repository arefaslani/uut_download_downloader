# Downloader

This is the downloader part of the uut_download project.

## Protocol Messages

A download request for this software is something like:
```
DOWNLOAD_ID: 12378
DOWNLOAD_PROTOCOL: HTTP

https://host.com/file.iso
```
The downloader listens to port 9000 as default and accepts a message as above. This message can come from another software(In this project it is called [Scheduler](http://github.com/arefaslani/uut_download_scheduler)) or simply using sockets.

A request consists of two parts, headers and body, that are separated with two \n characters.
Each header separates with a \n from the others. All Accepted headers are listed below:
* DOWNLOAD_ID: The id of the download link in the database. it is better to not use a autoincrement integer as the download id. instead use a unique 10 digit id for each of download links, for example.
* DOWNLOAD_PROTOCOL: for now it accepts only HTTP value.

## Binaries

This software consists of two binaries:

* downloader: runs the main downloader listener.
* downloader_web: runs a HTTP listener that the web application can simply work with it.

## HTTP Listener

The software has a simple web application inside it that other web application can communicate to the main process through it. As default it listens to port 4567. For now it only accepts a url like this:

http://localhost:4567/progress/[download_id].format

The download id is the id of the download link that requester wants to get it's progress. The format is type of the response. for example if you want the progress of the download link with id of 5326938310 as a xml document, you should get your response from this address:

http://localhost:4567/progress/5326938310.xml
<br>returns
```xml
<?xml version="1.0"?>
<file>
  <id>5326938310</id>
  <progress>59%</progress>
</file>
```

or as json:

http://localhost:4567/progress/5326938310.json
<br>returns
```json
{"file":{"id":"5326938310","progress":"59%"}}
```

## Installation

Clone the repository:
```
git clone git@github.com:arefaslani/uut_download_downloader.git
```
If you have not 'bundler' gem, first install it:
```
sudo gem install bundler
```
Install dependencies through running this command:
```
bundle install
```
Build the gem through
```
gem build downloader.gemspec
```
and install it through
```
gem install --local downloader-0.0.1.gem
```
and run downloader and downloader_web in separate terminal tabs.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/downloader/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
