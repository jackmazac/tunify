-- Users Table
CREATE TABLE Users (
    UserID INTEGER PRIMARY KEY AUTOINCREMENT,
    Username VARCHAR(30) NOT NULL UNIQUE,
    Email VARCHAR(30) NOT NULL UNIQUE,
    Password VARCHAR(30) NOT NULL,
    Salt VARCHAR(64),
    ProfileData TEXT
);

-- Content Table
CREATE TABLE Content (
    ContentID INTEGER PRIMARY KEY AUTOINCREMENT,
    UserID INT NOT NULL,
    Content TEXT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Artists Table
CREATE TABLE Artists (
    ArtistID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(30) NOT NULL,
    Biography TEXT
);

-- Albums Table
CREATE TABLE Albums (
    AlbumID INTEGER PRIMARY KEY AUTOINCREMENT,
    ArtistID INT NOT NULL,
    Title VARCHAR(30) NOT NULL,
    ReleaseDate DATE,
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID)
);

-- Songs Table
CREATE TABLE Songs (
    SongID INTEGER PRIMARY KEY AUTOINCREMENT,
    AlbumID INT,
    Title VARCHAR(30) NOT NULL,
    Artist VARCHAR(30) NOT NULL,
    Duration TIME NOT NULL,
    Album VARCHAR(30) NOT NULL,
    deleted INTEGER DEFAULT 0,
    FOREIGN KEY (AlbumID) REFERENCES Albums(AlbumID)
);

-- Playlists Table
CREATE TABLE Playlists (
    PlaylistID INTEGER PRIMARY KEY AUTOINCREMENT,
    UserID INT NOT NULL,
    Name VARCHAR(30) NOT NULL,
    Description TEXT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Favorites Table
CREATE TABLE Favorites (
    UserID INT NOT NULL,
    SongID INT NOT NULL,
    PRIMARY KEY (UserID, SongID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID)
);

-- User Interactions Table (for following and other interactions, simplified example)
CREATE TABLE UserInteractions (
    UserID_1 INT NOT NULL,
    UserID_2 INT NOT NULL,
    InteractionType VARCHAR(255),
    Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID_1) REFERENCES Users(UserID),
    FOREIGN KEY (UserID_2) REFERENCES Users(UserID),
    PRIMARY KEY (UserID_1, UserID_2, InteractionType)
);

-- View for Songs with Artist and Album information
CREATE VIEW SongDetails AS
SELECT s.SongID, s.Title, s.Artist, s.Duration, s.Album, a.Name AS ArtistName, al.Title AS AlbumTitle
FROM Songs s
JOIN Albums al ON s.AlbumID = al.AlbumID
JOIN Artists a ON al.ArtistID = a.ArtistID
WHERE s.deleted = 0;

-- View for User Favorite Songs with detailed information
CREATE VIEW UserFavoriteSongs AS
SELECT u.UserID, u.Username, s.SongID, s.Title AS SongTitle, a.Name AS ArtistName, al.Title AS AlbumTitle
FROM Favorites f
JOIN Users u ON f.UserID = u.UserID
JOIN Songs s ON f.SongID = s.SongID
JOIN Albums al ON s.AlbumID = al.AlbumID
JOIN Artists a ON al.ArtistID = a.ArtistID
WHERE s.deleted = 0;

-- View for Playlist Songs with User information
CREATE VIEW PlaylistSongDetails AS
SELECT p.PlaylistID, p.Name AS PlaylistName, u.UserID, u.Username, s.SongID, s.Title AS SongTitle
FROM Playlists p
JOIN Users u ON p.UserID = u.UserID
JOIN Favorites f ON p.PlaylistID = f.PlaylistID
JOIN Songs s ON f.SongID = s.SongID
WHERE s.deleted = 0;

-- Indexes for optimization (examples)
CREATE INDEX idx_artist_name ON Artists(Name);
CREATE INDEX idx_album_title ON Albums(Title);
CREATE INDEX idx_song_title ON Songs(Title);
CREATE INDEX idx_playlist_name ON Playlists(Name);
