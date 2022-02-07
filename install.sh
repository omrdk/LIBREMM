#[Install dependencieces]
sudo apt install qtbase5-dev qtdeclarative5-dev     \
                 libqt5multimedia5-plugins          \
                 qml-module-qtmultimedia            \
                 qml-module-qtquick-dialogs         \
                 qml-module-qtquick-controls        \
                 qml-module-qtquick-controls2       \
                 qml-module-qt-labs-settings        \
                 qml-module-qtquick-window2         \
                 qml-module-qt-labs-folderlistmodel \
                 qml-module-qt-labs-folderlistmodel
                 
#[Build and install]
cd build
cmake ..
make
sudo make install
