CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);
CREATE TABLE genres (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  image VARCHAR(255) NOT NULL
);
INSERT INTO genres (title, image) VALUES
('Technology', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/technology.avif'),
('Science', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/science.avif'),

('Children', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/children.avif'),
('Music', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/music.avif'),

('Romance', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/love.avif'),
('History', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/History.avif'),

('Fine arts', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Fine%20art.avif'),
('Law', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Law.avif');

CREATE TABLE books (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  author VARCHAR(255) NOT NULL,
  image VARCHAR(255) NOT NULL,
  bookpdf VARCHAR(255) NOT NULL,
  genre_id INT NOT NULL,
  FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE
);

INSERT INTO books (title, author, image, bookpdf, genre_id)
VALUES
('Big Dummy''s Guide to the Internet', 'Electronic Frontier Foundation', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/%20Guide%20to%20the%20Internet.avif', 'https://www.gutenberg.org/cache/epub/118/pg118-images.htmll',1),
('How to Succeed as an Inventor', 'Goodwin Brooke Smith', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/How%20to%20Succeed%20as%20an%20Inventor.avif', 'https://www.gutenberg.org/cache/epub/46512/pg46512-images.html',1),
('Technology and Books for All ', 'Marie Lebert', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/technology%20for%20all.avif', 'https://www.gutenberg.org/cache/epub/27098/pg27098-images.html',1),
('How it Works', 'Archibald WilliamsS', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/How%20it%20Works.avif', 'https://www.gutenberg.org/cache/epub/28553/pg28553-images.html',1),
('Practical Mechanics for Boys', 'James Slough Zerbe', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Practical%20Mechanics%20for%20Boys.avif', 'https://www.gutenberg.org/cache/epub/22298/pg22298-images.html',1),
('The Invention of the Sewing Machine', 'Grace Rogers Cooper', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/The%20Invention%20of%20the%20Sewing%20Machine.avif', 'https://www.gutenberg.org/cache/epub/32677/pg32677-images.html',1),
('The Early History of the Airplane', 'Orville Wright and Wilbur', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/The%20Early%20History%20of%20the%20Airplane.avif', 'https://www.gutenberg.org/cache/epub/25420/pg25420-images.html',1),
('Opportunities in Engineering', 'Charles M. Horton', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Opportunities%20in%20Engineering.avif', 'https://www.gutenberg.org/cache/epub/24681/pg24681-images.html',1),

('On Growth and Form', 'D''Arcy Wentworth Thompson', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/On%20Growth%20and%20Form.avif', 'https://www.gutenberg.org/cache/epub/55264/pg55264-images.html',2),
('On the Origin of Species By Means of Natural Selection', 'Charles Darwin', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/On%20the%20Origin%20of%20Species%20By%20Means.avif', 'https://www.gutenberg.org/cache/epub/1228/pg1228-images.html',2),
('The Nature of Animal Light', 'E. Newton Harvey', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/The%20Nature%20of%20Animal%20Light.avif', 'https://www.gutenberg.org/cache/epub/34450/pg34450-images.html',2),
('The life of the bee', 'Maurice Maeterlinck', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/THE%20LIFE%20OF%20THE%20BEE.avif', 'https://www.gutenberg.org/cache/epub/4511/pg4511-images.html',2),
('The Animal Story Book', 'Andrew Lang and H. J. Ford', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/The%20Animal%20Story%20Book.avif', 'https://www.gutenberg.org/cache/epub/38208/pg38208-images.html',2),
('Anecdotes of the Habits and Instinct of Animals', 'Mrs. R. Lee', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Anecdotes%20of%20the%20Habits%20and%20Instinct%20of%20Animals.avif', 'https://www.gutenberg.org/cache/epub/21973/pg21973-images.html',2),
('Indian Natural History Sketches', 'Douglas Dewar', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Indian%20Natural%20History%20Sketches.avif', 'https://www.gutenberg.org/cache/epub/46318/pg46318-images.html',2),
('Myths and Legends of Alaska', 'Katharine Berry Judson', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Myths%20and%20Legends%20of%20Alaska.avif', 'https://www.gutenberg.org/cache/epub/47146/pg47146-images.html',2),

('Alice''s Adventures in Wonderland', 'Lewis Carroll', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Alice%20s%20Adventures%20in%20Wonderland..avif', 'https://www.gutenberg.org/cache/epub/11/pg11-images.html',3),
('Grimms'' Fairy Tales', 'Jacob Grimm and Wilhelm Grimm', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Grimms%20Fairy%20Tales.avif', 'https://www.gutenberg.org/cache/epub/2591/pg2591-images.html',3),
('A Christmas Carol', 'Charles Dickens', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/A%20Christmas%20Carol%20.avif', 'https://www.gutenberg.org/cache/epub/24022/pg24022-images.html',3),
('Adventures of Huckleberry Finn', 'Mark Twain', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Adventures%20of%20Huckleberry%20Finn.avif', 'https://www.gutenberg.org/cache/epub/76/pg76-images.html',3),

('Beethoven''s Letters 1790-1826', 'Ludwig van Beethoven', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Beethoven''''s%20Letters%201790-1826.avif', 'https://www.gutenberg.org/cache/epub/13065/pg13065-images.html',4),
('The Congo, and Other Poems', 'Vachel Lindsay', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/The%20Congo%2C%20and%20Other%20Poems.avif', 'https://www.gutenberg.org/cache/epub/1021/pg1021-images.html',4),
('The Letters of Wolfgang Amadeus Mozart', 'Wolfgang Amadeus Mozart', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/The%20Letters%20of%20Wolfgang%20Amadeus%20Mozart.avif', 'https://www.gutenberg.org/cache/epub/5307/pg5307-images.html',4),
('The Boy''s Voice', 'J. Spencer Curwen', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/The%20Boys%20Voice.avif', 'https://www.gutenberg.org/cache/epub/32023/pg32023-images.html',4),
('The Phantom of the Opera', 'Gaston Leroux', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/The%20Phantom%20of%20the%20Opera.avif', 'https://www.gutenberg.org/cache/epub/175/pg175-images.html',4),


('Les adevineaux amoureux', 'Anonymous', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Les%20adevineaux%20amoureux.avif', 'https://www.gutenberg.org/cache/epub/57719/pg57719-images.html',5),
('A Romance of Nelson in the Year of the Nile', 'Sladen', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/A%20Romance%20of%20Nelson%20in%20the%20Year%20of%20the%20Nile.avif', 'https://www.gutenberg.org/cache/epub/47944/pg47944-images.html',5),

('Historische roman', 'Ludwig Rellstab', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Historische%20roman.avif', 'https://www.gutenberg.org/cache/epub/48216/pg48216-images.html',6),

('Michael Angelo Buonarroti', 'Charles Holroyd', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Michael%20Angelo%20Buonarroti.avif', 'https://www.gutenberg.org/cache/epub/19332/pg19332-images.html',7),
('The Sculpture and Mural Decorations of the Exposition', ' Stella G. S. Perry', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/The%20Sculpture%20and%20Mural%20Decorations%20of%20the%20Exposition.avif', 'https://www.gutenberg.org/cache/epub/6631/pg6631-images.html',7),

('The Common Law', 'Oliver Wendell Holmes', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/The%20Common%20Law.avif', 'https://www.gutenberg.org/cache/epub/2449/pg2449-images.html',8),
('The Strange Case of Dr. Jekyll and Mr. Hyde', 'Robert Louis Stevenson', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/The%20Strange%20Case.avif', 'https://www.gutenberg.org/cache/epub/42/pg42-images.html',8),
('Southern Horrors: Lynch Law in All Its Phases', 'Ida B. Wells-Barnett', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/Southern%20Horrors.avif', 'https://www.gutenberg.org/cache/epub/14975/pg14975-images.html',8),
('The Mysterious Affair at Styles', 'Agatha Christie', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/The%20Mysterious%20Affair%20at%20Styles.avif', 'https://www.gutenberg.org/cache/epub/863/pg863-images.html',8),
('On the Duty of Civil Disobedience', 'Henry David Thoreau', 'https://raw.githubusercontent.com/IssraaAlNhayle/Files/refs/heads/main/On%20the%20Duty%20of%20Civil%20Disobedience.avif', 'https://www.gutenberg.org/cache/epub/71/pg71-images.html',8);

CREATE TABLE reading (
    id SERIAL PRIMARY KEY,
    users_id INT NOT NULL,
    book_id INT NOT NULL,
    FOREIGN KEY (users_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
);

CREATE TABLE favorites (
    id SERIAL PRIMARY KEY,
    users_id INT NOT NULL,
    book_id INT NOT NULL,
    FOREIGN KEY (users_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
);

CREATE TABLE completed (
    id SERIAL PRIMARY KEY,
    users_id INT NOT NULL,
    book_id INT NOT NULL,
    FOREIGN KEY (users_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
);

Drop table reading;
Drop table completed;
Drop table favorites;
Drop table users;
Drop table books;
Drop table genres;

Delete from genres;
Delete from users;
select * from users;