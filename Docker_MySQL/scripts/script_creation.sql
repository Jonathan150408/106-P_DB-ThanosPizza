CREATE DATABASE db_Thanoss_Pizza;
USE db_Thanoss_Pizza;
CREATE TABLE t_client(
   client_id INT AUTO_INCREMENT,
   nom VARCHAR(50) NOT NULL,
   prenom VARCHAR(50),
   courriel VARCHAR(320),
   telephone VARCHAR(18),
   PRIMARY KEY(client_id)
);

CREATE TABLE t_adresse(
   adresse_id INT AUTO_INCREMENT,
   rue VARCHAR(50) NOT NULL,
   npa VARCHAR(50) NOT NULL,
   localite VARCHAR(50) NOT NULL,
   latitude DECIMAL(15,6),
   longitude DECIMAL(15,6),
   client_fk INT NOT NULL,
   PRIMARY KEY(adresse_id),
   FOREIGN KEY(client_fk) REFERENCES t_client(client_id)
);

CREATE TABLE t_produit(
   produit_id INT AUTO_INCREMENT,
   type VARCHAR(50) NOT NULL,
   nom VARCHAR(50) NOT NULL,
   prix_ttc DECIMAL(15,2) NOT NULL,
   tva INT NOT NULL,
   actif BOOLEAN NOT NULL,
   PRIMARY KEY(produit_id),
   UNIQUE(nom)
);

CREATE TABLE t_commande(
   commande_id INT AUTO_INCREMENT,
   type VARCHAR(50) NOT NULL,
   date_et_heure DATETIME NOT NULL,
   statut VARCHAR(50) NOT NULL,
   adresse_fk INT,
   client_fk INT NOT NULL,
   PRIMARY KEY(commande_id),
   FOREIGN KEY(adresse_fk) REFERENCES t_adresse(adresse_id),
   FOREIGN KEY(client_fk) REFERENCES t_client(client_id)
);

CREATE TABLE t_paiement(
   paiement_id INT AUTO_INCREMENT,
   mode VARCHAR(50) NOT NULL,
   montant DECIMAL(19,4) NOT NULL,
   date_paiement DATETIME NOT NULL,
   commande_fk INT NOT NULL,
   PRIMARY KEY(paiement_id),
   FOREIGN KEY(commande_fk) REFERENCES t_commande(commande_id)
);

CREATE TABLE t_ligne_de_commande(
   ligne_de_commande_id INT AUTO_INCREMENT,
   quantite INT NOT NULL,
   prix_unitaire DECIMAL(19,4) NOT NULL,
   commande_fk INT NOT NULL,
   produit_fk INT NOT NULL,
   produit_enfant_fk INT NOT NULL,
   PRIMARY KEY(ligne_de_commande_id),
   FOREIGN KEY(commande_fk) REFERENCES t_commande(commande_id),
   FOREIGN KEY(produit_fk) REFERENCES t_produit(produit_id),
   FOREIGN KEY(produit_enfant_fk) REFERENCES t_ligne_de_commande(ligne_de_commande_id)
);

CREATE TABLE t_livreur(
   livreur_id INT AUTO_INCREMENT,
   nom VARCHAR(50) NOT NULL,
   actif BOOLEAN NOT NULL,
   PRIMARY KEY(livreur_id)
);

CREATE TABLE t_livraison(
   livraison_id INT AUTO_INCREMENT,
   statut VARCHAR(50) NOT NULL,
   heure_depart DATETIME NOT NULL,
   heure_arrivee DATETIME,
   commande_fk INT NOT NULL,
   livreur_fk INT,
   PRIMARY KEY(livraison_id),
   FOREIGN KEY(commande_fk) REFERENCES t_commande(commande_id),
   FOREIGN KEY(livreur_fk) REFERENCES t_livreur(livreur_id)
);
