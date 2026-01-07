/* Création de la base de donnée */
USE [master];
GO

DROP DATABASE IF EXISTS [uaa5_db];
GO

CREATE DATABASE [uaa5_db];
GO

USE [uaa5_db];
GO

/* Structure de la base de donnée */

-- Catalogue de formation
CREATE TABLE [training_course] (
    [id] INT IDENTITY(1,1) NOT NULL,
    [name] NVARCHAR(50) NOT NULL,
    [short_desc] NVARCHAR(100) NOT NULL,
    [full_desc] NVARCHAR(1000) NULL,
    [image] VARCHAR(100) NOT NULL,
    [thumbnail] VARCHAR(100) NULL,
    [duration] INT NOT NULL,

    CONSTRAINT [PK_training_course]
        PRIMARY KEY ([id]),
    CONSTRAINT [UK_training_course__name]
        UNIQUE ([name])
);
GO

-- Planification des formations
CREATE TABLE [training_session] (
    [id] INT IDENTITY(1,1) NOT NULL,
    [training_course_id] INT NOT NULL,
    [info_session_datetime] DATETIME2 NOT NULL,
    [location] NVARCHAR(255) NOT NULL,
    [start_date] DATE NOT NULL,

    CONSTRAINT [PK_training_session]
        PRIMARY KEY ([id]),
    CONSTRAINT [FK_training_session__training_course] 
        FOREIGN KEY ([training_course_id]) 
        REFERENCES [training_course]([id])
);
GO

-- Inscriptions au séance d'info
CREATE TABLE [info_session_registration] (
    [id] INT IDENTITY(1,1) NOT NULL,
    [training_session_id] INT NOT NULL,
    [email] VARCHAR(255) NOT NULL,
    [newsletter_authorized] BIT NOT NULL,
    [registration_date] DATETIME2 DEFAULT(GETDATE()),
    
    CONSTRAINT [PK_session_registration]
        PRIMARY KEY ([id]),
    CONSTRAINT [UK_session_registration__session_email] 
        UNIQUE ([training_session_id], [email]),
    CONSTRAINT [FK_session_registration__training_session]
        FOREIGN KEY ([training_session_id]) 
        REFERENCES [training_session]([id])
);
GO

/* Données initials */

-- Catalogue de formation
SET IDENTITY_INSERT [training_course] ON;
INSERT INTO [training_course] ([id], [name], [short_desc], [full_desc], [image], [thumbnail], [duration])
 VALUES (1, 'Développeur Fullstack Svelte & C#', 'Formation intensive Web avec Svelte, C# et .NET', 'Maîtrisez le développement front-end avec Svelte et le back-end avec C# et le framework .NET pour concevoir des applications web performantes.', 'svelte_csharp.png', 'thumb_fs.png', 90), 
        (2, 'Data Analyst', 'Analyse de données et BI', 'Apprenez Python, SQL et PowerBI pour faire parler les données.', 'data_analyst.png', NULL, 45),
        (3, 'Cybersécurité', 'Sécurisation des réseaux', 'Introduction aux concepts de sécurité, firewall et tests d''intrusion.', 'cyber_secu.png', 'thumb_secu.png', 60),
        (4, 'UX/UI Designer', 'Conception d''interfaces', 'Création de maquettes et prototypes centrés utilisateur.', 'ux_ui.png', 'thumb_designer.png', 30),
        (5, 'Marketing Digital', 'SEO et Réseaux sociaux', 'Stratégie de communication digitale et analyse d''audience.', 'marketing.png', 'thumb_marketing.png', 15),
        (6, 'Développement IA', 'Conception et entraînement de modèles d''apprentissage automatique', 'Utilisation de Python et de frameworks comme TensorFlow pour l''IA et le Machine Learning.', 'ia_dev.jpg', NULL, 75);
SET IDENTITY_INSERT [training_course] OFF;
GO

-- Planification des formations
SET IDENTITY_INSERT [training_session] ON;
INSERT INTO [training_session] ([id], [training_course_id], [info_session_datetime], [location], [start_date])
 VALUES (1, 1, DATEADD(hour, 14, DATEADD(week, -6, DATEADD(month, -9, GETDATE()))), 'DigitalCity Bruxelles', CAST(DATEADD(month, -9, GETDATE()) AS DATE)), 
        (2, 4, DATEADD(hour, 10, DATEADD(week, -6, DATEADD(month, -6, GETDATE()))), 'DigitalCity Bruxelles', CAST(DATEADD(month, -6, GETDATE()) AS DATE)), 
        (3, 5, DATEADD(hour, 9, DATEADD(minute, 30, DATEADD(week, -6, DATEADD(month, 2, GETDATE())))), 'BF Site Tour & Taxis', CAST(DATEADD(month, 2, GETDATE()) AS DATE)),
        (4, 3, DATEADD(hour, 14, DATEADD(week, -7, DATEADD(month, 3, GETDATE()))), 'En ligne (BF E-learning)', CAST(DATEADD(month, 3, GETDATE()) AS DATE)),      
        (5, 6, DATEADD(hour, 11, DATEADD(week, -6, DATEADD(month, 3, GETDATE()))), 'BF Centre Schaerbeek', CAST(DATEADD(month, 3, GETDATE()) AS DATE)),
        (6, 5, DATEADD(hour, 9, DATEADD(week, -6, DATEADD(month, 8, GETDATE()))), 'BF Site Molenbeek', CAST(DATEADD(month, 8, GETDATE()) AS DATE)),           
        (7, 1, DATEADD(hour, 14, DATEADD(week, -6, DATEADD(year, 1, GETDATE()))), 'DigitalCity Bruxelles', CAST(DATEADD(year, 1, GETDATE()) AS DATE)),
        (8, 2, DATEADD(hour, 12, DATEADD(week, -5, DATEADD(year, 2, GETDATE()))), 'DigitalCity Bruxelles', CAST(DATEADD(year, 2, GETDATE()) AS DATE));
SET IDENTITY_INSERT [training_session] OFF;
GO

-- Inscriptions aux séances d'info
SET IDENTITY_INSERT [info_session_registration] ON;
INSERT INTO [info_session_registration] ([id], [training_session_id], [email], [newsletter_authorized], [registration_date])
 VALUES (1, 1, 'lucas.dubois@gmail.com', 1, (SELECT DATEADD(day, -25, info_session_datetime) FROM training_session WHERE id = 1)),
        (2, 1, 'marie.lefevre@outlook.com', 1, (SELECT DATEADD(day, -10, info_session_datetime) FROM training_session WHERE id = 1)),
        (3, 1, 'dark_coder_99@hotmail.com', 0, (SELECT DATEADD(day, -28, info_session_datetime) FROM training_session WHERE id = 1)),
        (4, 1, 'sophie.martin@yahoo.fr', 1, (SELECT DATEADD(day, -15, info_session_datetime) FROM training_session WHERE id = 1)),
        (5, 1, 'thomas.bernard@gmail.com', 0, (SELECT DATEADD(day, -8, info_session_datetime) FROM training_session WHERE id = 1)),
        (6, 1, 'svelte_fanboy@protonmail.com', 1, (SELECT DATEADD(day, -20, info_session_datetime) FROM training_session WHERE id = 1)),
        (7, 1, 'julie.petit@live.be', 1, (SELECT DATEADD(day, -12, info_session_datetime) FROM training_session WHERE id = 1)),
        (8, 1, 'maxime.robert@gmail.com', 0, (SELECT DATEADD(day, -9, info_session_datetime) FROM training_session WHERE id = 1)),
        (9, 1, 'csharp_guru@dev.net', 1, (SELECT DATEADD(day, -30, info_session_datetime) FROM training_session WHERE id = 1)),
        (10, 1, 'laura.richard@wanadoo.fr', 1, (SELECT DATEADD(day, -18, info_session_datetime) FROM training_session WHERE id = 1)),
        (11, 1, 'alexandre.durand@test.com', 0, (SELECT DATEADD(day, -22, info_session_datetime) FROM training_session WHERE id = 1)),
        (12, 1, 'web_master_x@gmail.com', 1, (SELECT DATEADD(day, -14, info_session_datetime) FROM training_session WHERE id = 1)),
        (13, 2, 'emma.moreau@gmail.com', 1, (SELECT DATEADD(day, -29, info_session_datetime) FROM training_session WHERE id = 2)),
        (14, 2, 'data.viz.queen@tableau.com', 1, (SELECT DATEADD(day, -7, info_session_datetime) FROM training_session WHERE id = 2)),
        (15, 2, 'nicolas.simon@outlook.fr', 0, (SELECT DATEADD(day, -14, info_session_datetime) FROM training_session WHERE id = 2)),
        (16, 2, 'chloe.michel@gmail.com', 1, (SELECT DATEADD(day, -21, info_session_datetime) FROM training_session WHERE id = 2)),
        (17, 2, 'python_snake@zoo.be', 0, (SELECT DATEADD(day, -19, info_session_datetime) FROM training_session WHERE id = 2)),
        (18, 2, 'antoine.leroy@live.fr', 1, (SELECT DATEADD(day, -11, info_session_datetime) FROM training_session WHERE id = 2)),
        (19, 2, 'sarah.roux@gmail.com', 1, (SELECT DATEADD(day, -25, info_session_datetime) FROM training_session WHERE id = 2)),
        (20, 2, 'big_data_boss@corp.com', 0, (SELECT DATEADD(day, -8, info_session_datetime) FROM training_session WHERE id = 2)),
        (21, 2, 'julien.david@yahoo.com', 1, (SELECT DATEADD(day, -16, info_session_datetime) FROM training_session WHERE id = 2)),
        (22, 2, 'manon.bertrand@gmail.com', 1, (SELECT DATEADD(day, -30, info_session_datetime) FROM training_session WHERE id = 2)),
        (23, 2, 'excel_is_life@office.com', 0, (SELECT DATEADD(day, -13, info_session_datetime) FROM training_session WHERE id = 2)),
        (24, 3, 'lea.garcia@hotmail.com', 1, (SELECT DATEADD(day, -20, info_session_datetime) FROM training_session WHERE id = 3)),
        (25, 3, 'seo_ninja_2000@web.com', 1, (SELECT DATEADD(day, -15, info_session_datetime) FROM training_session WHERE id = 3)),
        (26, 3, 'pierre.fournier@gmail.com', 0, (SELECT DATEADD(day, -9, info_session_datetime) FROM training_session WHERE id = 3)),
        (27, 3, 'camille.girard@outlook.com', 1, (SELECT DATEADD(day, -28, info_session_datetime) FROM training_session WHERE id = 3)),
        (28, 3, 'social_media_star@insta.com', 1, (SELECT DATEADD(day, -7, info_session_datetime) FROM training_session WHERE id = 3)),
        (29, 3, 'romain.bonnet@live.be', 0, (SELECT DATEADD(day, -22, info_session_datetime) FROM training_session WHERE id = 3)),
        (30, 3, 'clara.lambert@gmail.com', 1, (SELECT DATEADD(day, -18, info_session_datetime) FROM training_session WHERE id = 3)),
        (31, 3, 'growth_hacker@startup.io', 1, (SELECT DATEADD(day, -12, info_session_datetime) FROM training_session WHERE id = 3)),
        (32, 3, 'florian.dupuis@yahoo.fr', 0, (SELECT DATEADD(day, -26, info_session_datetime) FROM training_session WHERE id = 3)),
        (33, 3, 'oceane.guerin@gmail.com', 1, (SELECT DATEADD(day, -14, info_session_datetime) FROM training_session WHERE id = 3)),
        (34, 3, 'kevin.lecomte@test.fr', 1, (SELECT DATEADD(day, -30, info_session_datetime) FROM training_session WHERE id = 3)),
        (35, 3, 'adwords_pro@google.com', 0, (SELECT DATEADD(day, -10, info_session_datetime) FROM training_session WHERE id = 3)),
        (36, 3, 'mathieu.faure@gmail.com', 1, (SELECT DATEADD(day, -8, info_session_datetime) FROM training_session WHERE id = 3)),
        (37, 4, 'mr_robot@fsociety.com', 1, (SELECT DATEADD(day, -25, info_session_datetime) FROM training_session WHERE id = 4)),
        (38, 4, 'elise.blanc@gmail.com', 1, (SELECT DATEADD(day, -14, info_session_datetime) FROM training_session WHERE id = 4)),
        (39, 4, 'white_hat@secure.net', 0, (SELECT DATEADD(day, -8, info_session_datetime) FROM training_session WHERE id = 4)),
        (40, 4, 'hugo.mercier@outlook.com', 1, (SELECT DATEADD(day, -10, info_session_datetime) FROM training_session WHERE id = 4)),
        (41, 5, 'ai_researcher@future.com', 1, (SELECT DATEADD(day, -29, info_session_datetime) FROM training_session WHERE id = 5)),
        (42, 5, 'vincent.gauthier@gmail.com', 1, (SELECT DATEADD(day, -15, info_session_datetime) FROM training_session WHERE id = 5)),
        (43, 5, 'deep_learning_fan@neural.net', 0, (SELECT DATEADD(day, -7, info_session_datetime) FROM training_session WHERE id = 5));
SET IDENTITY_INSERT [info_session_registration] OFF;
GO