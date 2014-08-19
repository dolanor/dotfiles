"zeitgeist.vim - a Zeitgeist logger for Vim
"Author : Jonathan Lambrechts <jonathanlambrechts@gmail.com>
"Installation : drop this file in a vim plugin folder ($HOME/.vim/plugin,/usr/share/vim/vim72/plugin, ...). Vim should be compiled with python enabled.
"import gio

function! ZeitgeistLog(filename, vim_use_id)
python << endpython

import os
import vim
import time

try:
  __import__('imp').find_module('gio')
  gio_available = True
except ImportError:
  gio_available = False

try:
  __import__('imp').find_module('mimetypes')
  mimetypes_available = True
except ImportError:
  mimetypes_available = False

class ZeitgeistLogInstance:
  zeitgeistclient = None
  got_zeitgeist = False
  startzg = lambda : None


def start():
  try:
    import dbus
  except ImportError:
    return
  else:
    try:
      from zeitgeist.client import ZeitgeistClient
      from zeitgeist.datamodel import Subject, Event, Interpretation, Manifestation
      ZeitgeistLogInstance.zeitgeistclient = ZeitgeistClient()
      ZeitgeistLogInstance.got_zeitgeist = True

    except (RuntimeError, ImportError, dbus.exceptions.DBusException):
      ZeitgeistLogInstance.got_zeitgeist = False
    ZeitgeistLogInstance.startzg = lambda : None


if not hasattr(ZeitgeistLogInstance,'startzg'):
  ZeitgeistLogInstance.startzg = start

try:
  start()
  use_id = vim.eval("a:vim_use_id")
  filename = vim.eval("a:filename")
  precond = os.getuid() != 0 and os.getenv('DBUS_SESSION_BUS_ADDRESS') != None
  if ZeitgeistLogInstance.got_zeitgeist and precond and filename:
    from zeitgeist.datamodel import Subject, Event, Interpretation, Manifestation
    use = {
      "read" : Interpretation.ACCESS_EVENT,
      "new" : Interpretation.CREATE_EVENT,
      "write" : Interpretation.MODIFY_EVENT} [use_id]

    if gio_available == True:
      import gio
      f = gio.File(filename)
      fi = f.query_info(gio.FILE_ATTRIBUTE_STANDARD_CONTENT_TYPE)
      uri = f.get_uri()
      mimetype = fi.get_content_type()
    elif mimetypes_available == True:
      import mimetypes
      import urllib
      uri=urllib.pathname2url(filename)
      mimetype=mimetypes.guess_type(uri, strict=False).type
    else:
      uri=filename
      mimetype='application/octet-stream'

    subject = Subject.new_for_values(
      uri=unicode(uri),
      text=unicode(uri.rpartition("/")[2]),
      interpretation=unicode(Interpretation.DOCUMENT),
      manifestation=unicode(Manifestation.FILE_DATA_OBJECT),
      origin=unicode(uri.rpartition("/")[0]),
      mimetype=unicode(mimetype)
    )
    event = Event.new_for_values(
      timestamp=int(time.time()*1000),
      interpretation=unicode(use),
      manifestation=unicode(Manifestation.USER_ACTIVITY),
      actor="application://gvim.desktop",
      subjects=[subject,]
    )
    ZeitgeistLogInstance.zeitgeistclient.insert_event(event)
except:
  pass
endpython
endfunction

augroup zeitgeist
au!
au BufRead * call ZeitgeistLog (expand("%:p"), "read")
au BufNewFile * call ZeitgeistLog (expand("%:p"), "new")
au BufWrite * call ZeitgeistLog (expand("%:p"), "write")
augroup END

" vim: sw=2
