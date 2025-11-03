-- Création de la table des utilisateurs
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE
);

-- Insertion de quelques utilisateurs
INSERT INTO users (name, email) VALUES
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com'),
('Charlie', 'charlie@example.com');

-- Création d'une table de messages (exemple)
CREATE TABLE messages (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  content TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Insertion de messages de test
INSERT INTO messages (user_id, content) VALUES
(1, 'Bonjour depuis Docker !'),
(2, 'Connexion PHP ↔ MariaDB réussie 🚀'),
(3, 'Ceci est un message de test.');
