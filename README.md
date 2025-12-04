# plexamp-wrapped
A simple overview of your stats from the past over the past year:
## Instructions
### Gathering Plexamp Data
1. Find your Plex database - It's usually located at:

**Windows**: ```%LOCALAPPDATA%\Plex Media Server\Plug-in Support\Databases\com.plexapp.plugins.library.db```

**Mac**: ```~/Library/Application Support/Plex Media Server/Plug-in Support/Databases/com.plexapp.plugins.library.db```

**Linux**: ```/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-in Support/Databases/com.plexapp.plugins.library.db```

3. Use a SQLite browser (like DB Browser for SQLite) to open the database.
4. Run the below SQL query:
```
SELECT 
    track.title as title,
    artist.title as artist,
    album.title as album,
    track.duration / 1000 as duration,
    track.id as track_id,
    metadata_item_views.parent_title as view_parent,
    datetime(metadata_item_views.viewed_at, 'unixepoch', 'localtime') as played_at
FROM metadata_item_views
JOIN metadata_items track ON metadata_item_views.guid = track.guid
JOIN metadata_items album ON track.parent_id = album.id
JOIN metadata_items artist ON album.parent_id = artist.id
WHERE track.metadata_type = 10
  AND strftime('%Y', metadata_item_views.viewed_at, 'unixepoch', 'localtime') = strftime('%Y', 'now', 'localtime')
ORDER BY metadata_item_views.viewed_at DESC;
```
_Note: the above query will fitler out any results not from the current year which the query is run and does **not** show data from the past 365 days._
4. Export the result as a CSV file.

### To start plexamp-wrapped:

#### Linux:
1. Clone repository to your machine.
2. In the cloned directory, run "chmod +x start-plexwrapped.sh".
3. Run "./start-plexwrapped.sh" in the cloned directory.
4. When finished, hit ctrl+C in the terminal.
