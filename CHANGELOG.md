Hallon’s Changelog
==================

[HEAD][]
------------------

[v0.18.2][]
------------------
No changes to public API. Mostly some cleanup, and support for the new
Spotify gem.

- [470bc9786] Use weak_observable gem for weak reference callbacks.
- [b2feb8095] Require newest FFI and Spotify versions.

[v0.18.1][]
------------------
Hallon now supports spotify ~> 12.3.0. As a result, you no longer need to manually install
libspotify except in cases where the gem does not exist for your platform. I’ve tried to be
as liberal as possible in the gem platform choice, so manual installation should be a rare
occurrence.

This release mostly brings an internal change, and should not affect the public API, and as
such only the patch version has been increased.

[v0.18.0][]
------------------
This issue is to plug a bug of libspotify on Linux (see issue #125). The reason that
the minor version is increased is because of the update to libspotify v12.1.51.

__Changed__
- Upgrade to libspotify v12.1.51 [7c72ead7]
- All custom Hallon errors now inherit from Hallon::Error [950cf01]

__Fixed__
- Update documentation for observable hooks to not say they yield themselves [8c85c5e]
- Fixed race condition in audio format change [a5decb1]

[v0.17.0][]
------------------
Updated to libspotify v12.1.45, with all the good parts included!

__Added__

- New session callbacks [2f6e27f9]
- Support for image sizes [5f8156c]
- Add Session#username [4cce4c55]
- Support for specifying session proxy in Session#initialize [c61e5c5]
- Add Session#private? and Session#private= [bcf2805] (1000th commit!)
- Support for audio scrobbling [955a1b6, 627e0b, cf7957]

__Changed__

- Extracted Spotify::Pointer into Spotify gem [5cc88e9d]
- Move GC-wrapped functions to the Spotify gem [d8eda4]
- Moved error handling to Spotify gem [d31af5a]

[v0.16.0][]
------------------
This release brings a lot of changes to the Hallon test suite, mainly to make
it more readable and less of a mess.

__Added__

- ArtistBrowse#top_hits [5ef57a7]
- Session#flush_caches [693567]
- Track#playable_track [2d9cdfb]
- Support for playlists in search results [05f49e4]
- Support for suggestion search [1ae4b29]
- Support for unseen tracks for playlists in playlist containers [4bf8496]
- Support for login with credentials blob instead of password [61ffdf3]

__Changed__

- Removed the final `self` parameter of all libspotify events [d738a79]
- Renamed Playlist::Track#create_time to added_at [1adc2d7]
- Renamed Playlist::Track#creator to adder [1adc2d7]
- Session#offline_sync_status now returns a hash always [c14d42ae]
- Make AlbumBrowse#request_duration always return an integer [ee0697c2]
- Make ArtistBrowse#request_duration always return an integer [ee0697c2]
- Make Toplist#request_duration always return an integer [ebc64e1a]
- Track#popularity now returns a value between 0 and 100 [cd85ae7f]
- Move Session#wait_for onto Observable, now they all support it! [e14da3e]
- Make Playlist#update rely solely on callbacks [e703c132]
- Player.new no longer takes a session parameter [7508d18]
- Session.instance now raises NoSessionError on missing session [3b47b7]
- Observable#wait_for now calls original handler on events [be236bfd]

__Fixed__

- Have Playlist#subscribers always return an array [a8d26c9a]
- Fix Image#data for images with no data [e7d8627]
- Playlist::Track#message always return a string [72a644a]
- Session#login! now raises when given the wrong password [f650a36]
- Do not wrap the Session pointer in a Spotify pointer [9ae047d]
- Link.valid? segfaulting if having no session [84c9f69c]

[v0.15.0][]
------------------
Updated to libspotify v11.1.60 [3c810b0], and improved the examples provided within Hallon codebase significantly.

__Removed__

- Hallon::Search.radio (was removed in libspotify upgrade)

__Added__

- You can now construct Search objects from a Link! [7f87e74c]
- Playlist#upload [479c3d20, 2a90097]

__Changed__

- Observable#on now returns the previous handler [7ed42c4b]
- Default load time is now 30 seconds instead of 5 [d04440ba]

__Fixed__

- Hallon::URI now matches entire URIs [397cf711]
- Image IDs with NUL-bytes now no longer raise errors [30a376eb]
- Link#to_str/to_uri now returns a String in UTF-8 encoding [f1661736]
- Session#login now raises an error when given empty credentials [dbc390ea]

[v0.14.0][]
------------------
This release brings a lot more meat added to the README, in addition to the following:

__Added__

- Add #load to all loadable objects [acb508a, d554fb9]
  - Album
  - AlbumBrowse
  - Artist
  - ArtistBrowse
  - Image
  - Playlist
  - PlaylistContainer
  - Search
  - Toplist
  - Track
  - User
- Toplist#type [0ea8bac]
- Playlist.invalid_name? [a516cf0]
- User::Post#loaded? [373fd7]
- User::Post#message and User::Post#recipient_name [e31ff68]
- User::Post#recipient [4c6b71f]
- User::Post#tracks [1c407b6f]

__Changed__

- User::Post.create and User#post now accepts a single track [542f344]
- User::Post.new is now private, use User::Post.create instead [00ee6db]
- Toplist#artists/albums/tracks are now just Toplist#results [0ea8bac]
- Image#id(param) split up into Image#id and Image#raw_id [1bbd7def]
- Album#cover(param) split up into Album#cover and Album#cover_link [1bbd7def]
- Artist#portrait(param) split up into Artist#portrait and Artist#portrait_link [1bbd7def]
- Default cache_path and settings_path for Session#initialize are now both "tmp/hallon" [15573a7]

__Fixed__

- Playlist#remove accepting invalid parameters [91ccef6]
- Segfault in tracks_removed/tracks_moved playlist callbacks [46ac650]
- Observable#subscribe_for_callbacks subscribing to null pointers [f9cf72d]

[v0.13.0][]
------------------

Hallon v0.13.0 brings support for using external audio drivers with
the Hallon::Player API. The specification on how to write your own
driver is in the README.

An audio driver was also written as a separate gem:

    https://rubygems.org/gems/hallon-openal

__Added__

- Linkable#to_str, all linkable objects can now easily be converted to a spotify URI [132981a9]
- AudioQueue#clear/#synchronize/#new_cond (formerly Queue) [62bf4622, c2b14481, bb65cf28]
- AudioQueue#format/format= [27084a3a]

__Changed__

- Rewritten Player API (now deals in audio drivers) [53cfac21]
- Rewritten Enumerator system (Playlist#tracks, Search#albums et al) [676f7d1e]
- Search#{tracks,albums,artists}_total removed in favor of Search#{tracks,albums,artists}.total [d5c2e7aa]
- Image#== and Link#== [8a1e4a33]
- Player#load now accepts a spotify uri [710baf34]
- Renamed Queue to AudioQueue [c2b14481]
- Error.mabe_raise no longer ignores :is_loading, and now takes an :ignores option [53ad65c8]

__Fixed__

- Enumerators now check size before each iteration [4ec24969]
- Playlist#update_subscribers now returns the Playlist [86120836]

[v0.12.0][]
------------------

__Added__

- New system of handling callbacks (with documentation)
- Hallon::Queue (useful for music_delivery callback)
- PlaylistContainer::Folder#contents

__Changed__

- Rewrote the callback system (5f74ed8)
- Thread.abort_on_exception = true
- Upgraded to Spotify v10.3.0

__Fixed__

- Hallon::Error.maybe_raise(:is_loading) will not raise now
- UTF8 strings in applicable places for output/input
- Playlist#name= validation issue (allowing too long names)

[v0.11.0][]
------------------

__Added__

- Playlist#can_move?
- Base.from(pointer)

__Changed__

- Playlist#move no longer takes a dry_run parameter

__Fixed__

- Player#music_delivery callback ignoring consumed frames
- Session#wait_for minimum timeout time from 0 to 10 ms

[v0.10.1][] (actually v0.10.0)
------------------

__Added__

- Add PlaylistContainer::Folder#rename
- Add PlaylistContainer#insert_folder
- Add PlaylistContainer#move (do see #57)
- Add PlaylistContainer#remove
- Add ability to retrieve PlaylistContainer folders
- Make PlaylistContainer#add accept a spotify playlist URI
- Link.new now supports any #to_link’able object
- Playlist::Track#moved?
- PlaylistContainer callback support (to be changed, see #56)

__Fixed__

- A lot of random deadlocks (updated spotify gem dependency)

[v0.9.1][]
------------------

__Added__

- PlaylistContainer#size
- User#published
- PlaylistContainer#contents (only for playlists)
- PlaylistContainer#add (existing playlist, new playlist)

__Changed__

- Playlist#seen now moved to Playlist::Track#seen=

__Fixed__

- Album#cover null pointer issue (https://github.com/Burgestrand/Hallon/issues/53)
- Various possible null pointer bugs

[v0.9.0][]
------------------

- Upgraded to libspotify *v10*
- Improve documentation consistency
- Link.new now raises an error if there’s no session
- Minimal PlaylistContainer support (more to come next version)

__Added__

- Playlist subsystem support
- Toplist#request_duration
- AlbumBrowse#request_duration
- ArtistBrowse#request_duration
- ArtistBrowse.types
- Player#volume_normalization(?|=)
- Session.new accepting device_id/tracefile options
- Session#login!/relogin!/logout! convenience methods
- Session#starred: starred playlist for currently logged in user
- Session#inbox: inbox for currently logged in user
- Session.instance?
- Image.new(image_id_in_hex) support
- Link#to_uri
- User.new(canonical_username)
- User#post: posting tracks to other users’ inboxes
- User#starred: starred playlist of a given user
- Track#placeholder?
- Track#offline_status
- Track#unwrap
- type parameter to Artist#browse

__Fixed__

- Moved from using FFI::Pointers to Spotify::Pointers
- Spotify::Pointer garbage collection
- Link#valid? using exceptions for flow control
- Session#connection_rules= now raises an error when given invalid rule
- Search.radio now raises an error when given invalid genres

__Changed__

- Playlist::Track#seen= removed in favor of Playlist#seen(index, yesno)
- Object#error -> Object#status (AlbumBrowse, ArtistBrowse, Search, Toplist, User)
- Album#year renamed to Album#release_year
- Linkable.from_link/to_link and resulting #from_link are now private


[v0.8.0][]
------------------

__Added__

- Add example for listing track information in playlists
- Updated to (lib)Spotify v9
- Full Track subsystem support
- Full Album subsystem support
- Full AlbumBrowse subsystem support
- Full Artist subsystem support
- Full ArtistBrowse subsystem support
- Full Toplist subsystem support
- Full Search subsystem support
- Allow setting Session connection type/rules
- Session offline query methods (offline_time_left et al)
- Work-in-progress Player
- Add Session relogin support
- Add Enumerator
- Use libmockspotify for testing (spec/mockspotify)
- Add Hallon::Base class
- Add optional parameter to have Image#id return raw id
- Allow Image.new to accept an image id
- Add Hallon::API_BUILD

__Fixed__

- Improve speed of Session#wait_for for already-loaded cases
- Error.maybe_raise no longer errors out on timeout
- from_link now checks for null pointers
- No longer uses autotest as development dependency
- Cleaned up specs to use same mocks everywhere
- Make Hallon::URI match image URIs

__Broke__

- Ignore Ruby v1.8.x compatibility

[v0.3.0][]
------------------

- Don’t use bundler for :spec and :test rake tasks
- Add Error.table
- Add Track subsystem
- Fix spec:cov and spotify:coverage rake tasks

[v0.2.1][]
------------------

- Fix compatibility with v1.8

[v0.2.0][]
------------------

- Alias Session#process_events_on to Session#wait_until
- Have Error.maybe_raise return error code
- Use mockspotify gem (https://rubygems.org/gems/mockspotify) for testing

[v0.1.1][]
------------------

- Don’t show the README in the gem description.

[v0.1.0][]
------------------

Initial, first, release! This version is merely made to
have a starting point, a point of reference, for future
releases soon to come.

- Error subsystem is covered (`sp_error_message(error_code)`)
- Image subsystem is complete, however you can only create images
  from links at this moment.
- Session API is partial. Currently you can login, logout, retrieve
  the logged in user and query user relations.
- User API is complete, but you can only create users from your
  currently logged in user (through Session) or from links.

The API is still very young, and I expect a lot of changes to
happen to it, to make the asynchronous nature of libspotify
easier to handle.

[v0.1.0]: https://github.com/Burgestrand/Hallon/compare/5f2e118...v0.1.0
[v0.1.1]: https://github.com/Burgestrand/Hallon/compare/v0.1.0...v0.1.1
[v0.2.0]: https://github.com/Burgestrand/Hallon/compare/v0.1.1...v0.2.0
[v0.2.1]: https://github.com/Burgestrand/Hallon/compare/v0.2.0...v0.2.1
[v0.3.0]: https://github.com/Burgestrand/Hallon/compare/v0.2.1...v0.3.0
[v0.8.0]: https://github.com/Burgestrand/Hallon/compare/v0.3.0...v0.8.0
[v0.9.0]: https://github.com/Burgestrand/Hallon/compare/v0.8.0...v0.9.0
[v0.9.1]: https://github.com/Burgestrand/Hallon/compare/v0.9.0...v0.9.1
[v0.10.1]: https://github.com/Burgestrand/Hallon/compare/v0.9.1...v0.10.1
[v0.11.0]: https://github.com/Burgestrand/Hallon/compare/v0.10.1...v0.11.0
[v0.12.0]: https://github.com/Burgestrand/Hallon/compare/v0.11.0...v0.12.0
[v0.13.0]: https://github.com/Burgestrand/Hallon/compare/v0.12.0...v0.13.0
[v0.14.0]: https://github.com/Burgestrand/Hallon/compare/v0.13.0...v0.14.0
[v0.15.0]: https://github.com/Burgestrand/Hallon/compare/v0.14.0...v0.15.0
[v0.16.0]: https://github.com/Burgestrand/Hallon/compare/v0.15.0...v0.16.0
[v0.17.0]: https://github.com/Burgestrand/Hallon/compare/v0.16.0...v0.17.0
[v0.18.0]: https://github.com/Burgestrand/Hallon/compare/v0.17.0...v0.18.0
[v0.18.1]: https://github.com/Burgestrand/Hallon/compare/v0.18.0...v0.18.1
[HEAD]: https://github.com/Burgestrand/Hallon/compare/v0.18.1...HEAD
