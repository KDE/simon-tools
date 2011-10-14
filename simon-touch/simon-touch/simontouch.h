#ifndef SIMONTOUCH_H
#define SIMONTOUCH_H

class ImagesModel;
class VideosModel;
class MusicModel;

class SimonTouch
{
private:
    ImagesModel *m_images;
    MusicModel *m_music;
    VideosModel *m_videos;
public:
    SimonTouch(ImagesModel *img, MusicModel *music, VideosModel *videos);
};

#endif // SIMONTOUCH_H
