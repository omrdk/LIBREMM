if(NOT DEFINED CMAKE_MINIMUM_REQUIRED_VERSION)
    cmake_minimum_required(VERSION 3.16)
endif()

project(LIBREMM LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)               # auto generate qt moc rules

set(CMAKE_CXX_STANDARD 11)

set(PROJECT_DIR ${CMAKE_SOURCE_DIR})

set(PROJECT_SOURCE_DIR ${PROJECT_DIR}/src)
set(PROJECT_INCLUDE_DIR ${PROJECT_DIR}/inc)

set(PROJECT_SOURCES
            ${PROJECT_SOURCE_DIR}/main.cpp
            ${PROJECT_SOURCE_DIR}/backoffice.cpp
            ${PROJECT_SOURCE_DIR}/playlistmodal.cpp
            )
set(PROJECT_HEADERS
            ${PROJECT_INCLUDE_DIR}/backoffice.h
            ${PROJECT_INCLUDE_DIR}/srtparser.h
            ${PROJECT_INCLUDE_DIR}/playlistmodal.h
            ${PROJECT_INCLUDE_DIR}/iconv.hpp
            )

find_package(Qt5 COMPONENTS Quick Qml QuickWidgets Multimedia REQUIRED)

find_package(Iconv REQUIRED)

qt5_add_resources(RSCS qml/qml.qrc icons/icons.qrc)

include_directories(${PROJECT_INCLUDE_DIR})

add_executable(${PROJECT_NAME} ${PROJECT_SOURCES} ${PROJECT_HEADERS} ${RSCS})

target_link_libraries(${PROJECT_NAME} PRIVATE Qt5::Quick Qt5::Qml Qt5::QuickWidgets Qt5::Multimedia iconv)

install(TARGETS LIBREMM DESTINATION bin)
