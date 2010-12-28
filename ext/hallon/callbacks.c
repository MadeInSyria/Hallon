#include "common.h"
#include "events.h" /* hn_event_t */
#include "callbacks.h"
#include "session.h" /* hn_session_data_t */

#define SESSION_EVENT_CREATE(_session_ptr, _handler, _data) do {\
  hn_session_data_t *_session_data = (hn_session_data_t*) sp_session_userdata(_session_ptr);\
  DEBUG("!! " #_handler " !!");\
  EVENT_CREATE((_session_data)->event, _handler, _data, &(_session_data)->event_cond, &(_session_data)->event_mutex);\
  DEBUG("** " #_handler " **");\
} while(0)

/*
  Used for debugging purposes of event system. (see Session#fire!)

  @TODO: Remove this.
*/
static VALUE ruby_session_fire(void *args)
{
  return (VALUE) args;
}

VALUE hn_session_fire(void *_argv)
{
  void **argv = (void**) _argv;
  SESSION_EVENT_CREATE((sp_session*) argv[0], ruby_session_fire, argv[1]);
}


/*
  Session callbacks
  
  @see http://developer.spotify.com/en/libspotify/docs/structsp__session__callbacks.html
*/

/*
  Called when processing needs to take place on the main thread.
*/
static VALUE ruby_process_events(void *args)
{
  return rb_ary_new3(1, STR2SYM("process_events"));
}

static void callback_process_events(sp_session *session_ptr)
{
  SESSION_EVENT_CREATE(session_ptr, ruby_process_events, NULL);
  SESSION_EVENT_CREATE(session_ptr, ruby_process_events, NULL);
  SESSION_EVENT_CREATE(session_ptr, ruby_process_events, NULL);
}

/*
  Called when login has been processed and was successful.
*/
static VALUE ruby_logged_in(void *error)
{
  return rb_ary_new3(2, STR2SYM("logged_in"), INT2FIX((sp_error)error));
}

static void callback_logged_in(sp_session *session_ptr, sp_error error)
{
  SESSION_EVENT_CREATE(session_ptr, ruby_logged_in, (void*) error);
}

// @see session.c
const sp_session_callbacks HALLON_SESSION_CALLBACKS = 
{
 .logged_in              = callback_logged_in,
 .logged_out             = NULL,
 .metadata_updated       = NULL,
 .connection_error       = NULL,
 .message_to_user        = NULL,
 .play_token_lost        = NULL,
 .streaming_error        = NULL,
 .log_message            = NULL,
 .userinfo_updated       = NULL,
 .notify_main_thread     = callback_process_events,
 .music_delivery         = NULL,
 .end_of_track           = NULL,
 .start_playback         = NULL,
 .stop_playback          = NULL,
 .get_audio_buffer_stats = NULL
};