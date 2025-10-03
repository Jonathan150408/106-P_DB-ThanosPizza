CREATE DATABASE db_Thanoss_Pizza;
USE db_Thanoss_Pizza;
CREATE TABLE t_client(
   client_id INT AUTO_INCREMENT,
   courriel VARCHAR(320),
   telephone VARCHAR(18) NOT NULL,
   nom VARCHAR(50) NOT NULL,
   prenom VARCHAR(50),
   PRIMARY KEY(client_id),
   UNIQUE(courriel),
   UNIQUE(telephone)
);

CREATE TABLE t_adresse(
   adresse_id INT AUTO_INCREMENT,
   rue VARCHAR(50) NOT NULL,
   npa VARCHAR(50) NOT NULL,
   localite VARCHAR(50) NOT NULL,
   PRIMARY KEY(adresse_id)
);

CREATE TABLE t_produit(
   produit_id INT AUTO_INCREMENT,
   nom VARCHAR(50) NOT NULL,
   type VARCHAR(50) NOT NULL,
   prix DECIMAL(19,4) NOT NULL,
   tva INT NOT NULL,
   etat BOOLEAN NOT NULL,
   PRIMARY KEY(produit_id),
   UNIQUE(nom)
);

CREATE TABLE t_commande(
   commande_id INT AUTO_INCREMENT,
   date_et_heure DATETIME NOT NULL,
   type VARCHAR(50) NOT NULL,
   adresse_de_livraison VARCHAR(50),
   quantite TINYINT NOT NULL,
   statut VARCHAR(50) NOT NULL,
   client_fk INT NOT NULL,
   PRIMARY KEY(commande_id),
   FOREIGN KEY(client_fk) REFERENCES t_client(client_id)
);

CREATE TABLE t_ligne_de_commande(
   ligne_de_commande_id INT AUTO_INCREMENT,
   quantite INT NOT NULL,
   prix_unitaire DECIMAL(19,4) NOT NULL,
   commande_fk INT NOT NULL,
   produit_enfant_fk INT NOT NULL,
   PRIMARY KEY(ligne_de_commande_id),
   FOREIGN KEY(commande_fk) REFERENCES t_commande(commande_id),
   FOREIGN KEY(produit_enfant_fk) REFERENCES t_ligne_de_commande(ligne_de_commande_id)
);

CREATE TABLE t_livreur(
   livreur_id INT AUTO_INCREMENT,
   courriel VARCHAR(50),
   telephone VARCHAR(50),
   nom VARCHAR(50) NOT NULL,
   prenom VARCHAR(50) NOT NULL,
   PRIMARY KEY(livreur_id),
   UNIQUE(courriel),
   UNIQUE(telephone)
);

CREATE TABLE t_livraison(
   livraison_id INT AUTO_INCREMENT,
   heure_depart DATETIME NOT NULL,
   distance_estimee INT,
   heure_arrivee DATETIME,
   adresse_fk INT NOT NULL,
   livreur_fk INT,
   PRIMARY KEY(livraison_id),
   FOREIGN KEY(adresse_fk) REFERENCES t_adresse(adresse_id),
   FOREIGN KEY(livreur_fk) REFERENCES t_livreur(livreur_id)
);

CREATE TABLE t_paiement(
   paiement_id INT AUTO_INCREMENT,
   mode VARCHAR(50) NOT NULL,
   montant_paye DECIMAL(19,4) NOT NULL,
   montant_rendu DECIMAL(19,4) NOT NULL,
   livrsaison_fk INT NOT NULL,
   commande_fk INT NOT NULL,
   PRIMARY KEY(paiement_id),
   FOREIGN KEY(livrsaison_fk) REFERENCES t_livraison(livraison_id),
   FOREIGN KEY(commande_fk) REFERENCES t_commande(commande_id)
);

CREATE TABLE t_posseder(
   client_fk INT,
   adresse_fk INT,
   PRIMARY KEY(client_fk, adresse_fk),
   FOREIGN KEY(client_fk) REFERENCES t_client(client_id),
   FOREIGN KEY(adresse_fk) REFERENCES t_adresse(adresse_id)
);

CREATE TABLE t_comprendre(
   produit_fk INT,
   ligne_de_commande_fk INT,
   PRIMARY KEY(produit_fk, ligne_de_commande_fk),
   FOREIGN KEY(produit_fk) REFERENCES t_produit(produit_id),
   FOREIGN KEY(ligne_de_commande_fk) REFERENCES t_ligne_de_commande(ligne_de_commande_id)
);
