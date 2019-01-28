# FILMZ LEAGENDARY (version 1.0.0)

This is a blog web application it has the following users
1. Guests
2. Artist
3. Admin

## Version Dependencies
    ruby 2.3.3p222 (2016-11-21 revision 56859) [i386-mingw32]

    rails 5.1.6

    npm 5.6.0

## Running the application

### step 1 :
    clone : git clone git@gitbucket.org:Douye

### step 2 :
    migrate database : rails db:migrate

### step 3 :
    run server : rails s

## Site Requirements

### Support
1. Mobile(offline/online)
2. Desktop(online/offline)

### Admin
1. Upload (videos, news and music)
2. CRUD (videos, news and music)
3. Dashboard

### Users
1. Download (musics and videos)
2. Listen/Watch (musics and videos)

### Artists
1. CRUD (music)
2. Send/receive messages from (artists)
3. Dashboard

## Implemented functionalities
### Support
1. Mobile(offline/online) 40%
2. Desktop(online/offline) 0%

### Admin
1. Upload (videos, news and music) 60%
2. CRUD (videos, news and music) 50%
3. Dashboard 0%

### Users
1. Download (musics and videos) 80%
2. Listen/Watch (musics and videos) 80%

### Artists
1. CRUD (music) 0%
2. Send/receive messages from (artists) 0%
3. Dashboard 0%

## Currently active routes

    root GET    /                           films#index
#### General
    admin_index GET    /admin_index(.:format)      admins#index

#### Musics
    music_download POST   /music_download(.:format)   musics#download
            musics GET    /musics(.:format)           musics#index
                   POST   /musics(.:format)           musics#create
        new_music GET    /musics/new(.:format)       musics#new
        music GET    /musics/:id(.:format)       musics#show

#### Videos
        videos GET    /videos(.:format)           videos#index
               POST   /videos(.:format)           videos#create
     new_video GET    /videos/new(.:format)       videos#new
    edit_video GET    /videos/:id/edit(.:format)  videos#edit
         video GET    /videos/:id(.:format)       videos#show
    video_download POST   /video_download(.:format)   videos#download

#### News
    news_index GET    /news(.:format)             news#index
               POST   /news(.:format)             news#create

#### Artists
       artists GET    /artists(.:format)          artists#index
