#include "simontouch.h"
#include "imagesmodel.h"
#include "musicmodel.h"
#include "videosmodel.h"

SimonTouch::SimonTouch(ImagesModel *img, MusicModel *music, VideosModel *videos) :
    m_images(img), m_music(music), m_videos(videos)
{
}
