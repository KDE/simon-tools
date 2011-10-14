#ifndef SIMONTOUCHVIEW_H
#define SIMONTOUCHVIEW_H

class ImagesModel;
class VideosModel;
class MusicModel;

class SimonTouchView
{
private:
    ImagesModel *m_images;
    MusicModel *m_music;
    VideosModel *m_videos;
public:
    SimonTouchView(ImagesModel *img, MusicModel *music, VideosModel *videos);
};

#endif // SIMONTOUCHVIEW_H
