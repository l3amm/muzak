import requests
import json
import urllib

SERVER = 'http://10.1.10.75:1337'
headers = {'content-type': 'application/json'}
playlist_id = 'spotify:user:yandavid:playlist:5kgZph1yXFeYPsDng0OKxR'

print "/user/yandavid/playlists"
r = requests.get('%s/user/yandavid/playlists' % SERVER)

data = json.loads(r.content)

for playlist in data['playlists']:
  if playlist.get('title', None) == 'Euclid':
    print json.dumps(playlist, indent=4)


print "/playlist/%s" % playlist_id
r = requests.get('%s/playlist/%s' % (SERVER, playlist_id))
print json.dumps(json.loads(r.content), indent=4)

track1 = "spotify:track:1HDdzNybLH12mlvZqtizwX"
track2 = "spotify:track:3Ozk4jSRueNV1s4pukNcHM"
track3 = "spotify:track:1HWV0QlopyBUN6vWWLH6nk"

print "/playlist/%s/add?index=%d" % (playlist_id, 0)
songs = [track1, track3]
r = requests.post('%s/playlist/%s/patch' % (SERVER, playlist_id), data = json.dumps(songs))
print r.content
r.raise_for_status()