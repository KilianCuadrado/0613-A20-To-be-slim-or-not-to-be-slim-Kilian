PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE grupos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT NOT NULL UNIQUE,
            desc TEXT NOT NULL,
            img TEXT,
            generos TEXT,
            fechaCreacion TEXT
        );
INSERT INTO grupos VALUES(1,'Tame Impala','Banda/proyecto musical: Tame Impala.','https://static1.ara.cat/clip/3b95c771-8435-45a9-9528-d2af433f9a0f_16-9-aspect-ratio_default_0_x2637y1374.jpg','alternative, alternative dance, alternative rock, alternative/indie rock, australia, australian','1986-01-20');
INSERT INTO grupos VALUES(2,'Arctic Monkeys','Banda/proyecto musical: Arctic Monkeys.','https://i.scdn.co/image/ab6761610000e5eb7da39dea0a72f581535fb11f','alternative, alternative rock, alternative/indie rock, art rock, baroque pop, british','2002');
INSERT INTO grupos VALUES(3,'Gorillaz','virtual band','https://media.revistagq.com/photos/5ca5f4d3267a322393724870/4:3/w_1864,h_1398,c_limit/gorillaz_425.jpg','alternative dance, alternative rock, art pop, british, electronic, electronica','1999');
INSERT INTO grupos VALUES(4,'Jamiroquai','Banda/proyecto musical: Jamiroquai.','https://www.agendadesevilla.com/wp-content/uploads/2026/06/Jamiroquai-Iconica-Sevilla-2026.jpg','acid jazz, british, disco, funk, house, nuno','1992');
INSERT INTO grupos VALUES(5,'The White Stripes','Banda/proyecto musical: The White Stripes.','https://www.nme.com/wp-content/uploads/2016/10/whitestripes_DC_L71009-1.jpg','2000''s, alternative rock, american, blues rock, detroit, garage punk','1997-07-14');
INSERT INTO grupos VALUES(6,'Mac DeMarco','Banda/proyecto musical: Mac DeMarco.','https://upload.wikimedia.org/wikipedia/commons/f/fe/Mac_DeMarco_2019_%2848210650642%29_%28cropped%29.jpg','folk pop, indie pop, indie rock, jangle pop, jizz jazz, lo-fi indie','1990-04-30');
INSERT INTO grupos VALUES(7,'Limp Bizkit','Banda/proyecto musical: Limp Bizkit.','https://m.media-amazon.com/images/M/MV5BNjY0ZTcwODAtMzU4ZS00ZjhiLWFiNWItYjU0ZDk3ODI1YjUyXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg','2008 universal fire victim, alternative metal, alternative rock, american, crossover, hard alternative','1994');
INSERT INTO grupos VALUES(8,'The Strypes','Banda/proyecto musical: The Strypes.','https://static.standard.co.uk/s3fs-public/thumbnails/image/2014/02/20/17/strypes.jpg?quality=75&auto=webp&width=960','blues, blues rock, garage rock, rhythm and blues, rock and roll','2010-11-01');
INSERT INTO grupos VALUES(9,'Catfish and the Bottlemen','Banda/proyecto musical: Catfish and the Bottlemen.','https://static.independent.co.uk/s3fs-public/thumbnails/image/2014/11/14/12/Catfish_band3.jpg','2010s, alternative rock, garage punk, indie rock, post-punk revival','2007');
CREATE TABLE personas (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT NOT NULL,
            edad INTEGER,
            grupo TEXT NOT NULL,
            instrumento TEXT,
            fechaNacimiento TEXT
        , estadoMiembro TEXT NOT NULL DEFAULT 'integrante', miembroOficialEstable INTEGER NOT NULL DEFAULT 0);
INSERT INTO personas VALUES(1,'Kevin Parker',40,'Tame Impala','Voz y multiinstrumentista','1986-01-20','integrante',1);
INSERT INTO personas VALUES(2,'Andy Nicholson',40,'Arctic Monkeys','bass guitar','1986-04-09','exintegrante',1);
INSERT INTO personas VALUES(3,'Alex Turner',40,'Arctic Monkeys','percussion','1986-01-06','integrante',1);
INSERT INTO personas VALUES(4,'Jamie Cook',40,'Arctic Monkeys','background vocals','1985-07-08','integrante',1);
INSERT INTO personas VALUES(5,'Matt Helders',40,'Arctic Monkeys','background vocals, drums (drum set), percussion','1986-05-07','integrante',1);
INSERT INTO personas VALUES(6,'Nick O’Malley',40,'Arctic Monkeys','background vocals, bass guitar','1985-07-05','integrante',1);
INSERT INTO personas VALUES(7,'Paula Cracker',28,'Gorillaz','guitar','1998','exintegrante',0);
INSERT INTO personas VALUES(8,'2D',28,'Gorillaz','keyboard, lead vocals, melodica','1998','integrante',1);
INSERT INTO personas VALUES(9,'Russel Hobbs',28,'Gorillaz','drums (drum set), percussion','1998','integrante',1);
INSERT INTO personas VALUES(10,'Murdoc Niccals',28,'Gorillaz','bass guitar, drum machine','1998','integrante',1);
INSERT INTO personas VALUES(11,'Noodle',28,'Gorillaz','background vocals, guitar, keyboard','1998','integrante',1);
INSERT INTO personas VALUES(12,'Del Tha Ghost Rapper',26,'Gorillaz','spoken vocals','2000','exintegrante',0);
INSERT INTO personas VALUES(13,'Cyborg Noodle',16,'Gorillaz','guitar family','2010','exintegrante',0);
INSERT INTO personas VALUES(14,'Ace',8,'Gorillaz','bass','2018','exintegrante',0);
INSERT INTO personas VALUES(15,'Wallis Buchanan',60,'Jamiroquai','didgeridoo','1965-11-29','exintegrante',1);
INSERT INTO personas VALUES(16,'Toby Smith',55,'Jamiroquai','keyboards','1970-10-29','exintegrante',1);
INSERT INTO personas VALUES(17,'Jay Kay',56,'Jamiroquai','lead vocals','1969-12-30','integrante',1);
INSERT INTO personas VALUES(18,'Nick Van Gelder',0,'Jamiroquai','Dato sin confirmar','Dato sin confirmar','exintegrante',0);
INSERT INTO personas VALUES(19,'Maurizio Ravalico',63,'Jamiroquai','Dato sin confirmar','1963','exintegrante',0);
INSERT INTO personas VALUES(20,'Gavin Dodds',0,'Jamiroquai','Dato sin confirmar','Dato sin confirmar','exintegrante',0);
INSERT INTO personas VALUES(21,'John Thirkell',67,'Jamiroquai','Dato sin confirmar','1958-08-26','exintegrante',0);
INSERT INTO personas VALUES(22,'Stuart Zender',52,'Jamiroquai','bass','1974-03-18','exintegrante',1);
INSERT INTO personas VALUES(23,'DJ D-Zire',0,'Jamiroquai','Dato sin confirmar','Dato sin confirmar','exintegrante',0);
INSERT INTO personas VALUES(24,'Derrick McKenzie',62,'Jamiroquai','drums (drum set)','1964-03-27','integrante',1);
INSERT INTO personas VALUES(25,'Simon Katz',54,'Jamiroquai','guitar, bass, keyboards','1971-05-16','exintegrante',1);
INSERT INTO personas VALUES(26,'Sola Akingbola',60,'Jamiroquai','percussion','1965-08-02','integrante',1);
INSERT INTO personas VALUES(27,'Nick Fyffe',53,'Jamiroquai','bass guitar','1972-10-14','exintegrante',1);
INSERT INTO personas VALUES(28,'Simon Carter',0,'Jamiroquai','Dato sin confirmar','Dato sin confirmar','exintegrante',0);
INSERT INTO personas VALUES(29,'Samantha Smith',0,'Jamiroquai','background vocals','Dato sin confirmar','exintegrante',0);
INSERT INTO personas VALUES(30,'Rob Harris',0,'Jamiroquai','guitar','Dato sin confirmar','integrante',1);
INSERT INTO personas VALUES(31,'Matt Johnson',57,'Jamiroquai','keyboards','1969-02-03','integrante',1);
INSERT INTO personas VALUES(32,'Paul Turner',58,'Jamiroquai','bass guitar','1968-03-11','integrante',1);
INSERT INTO personas VALUES(33,'Howard Anderson',0,'Jamiroquai','Dato sin confirmar','Dato sin confirmar','exintegrante',0);
INSERT INTO personas VALUES(34,'Hazel Fernandes',0,'Jamiroquai','Dato sin confirmar','Dato sin confirmar','exintegrante',0);
INSERT INTO personas VALUES(35,'Dee Lewis',0,'Jamiroquai','Dato sin confirmar','Dato sin confirmar','exintegrante',0);
INSERT INTO personas VALUES(36,'Lorraine McIntosh',0,'Jamiroquai','Dato sin confirmar','Dato sin confirmar','exintegrante',0);
INSERT INTO personas VALUES(37,'Adrian Revell',0,'Jamiroquai','Dato sin confirmar','Dato sin confirmar','exintegrante',0);
INSERT INTO personas VALUES(38,'Winston Rollins',0,'Jamiroquai','Dato sin confirmar','Dato sin confirmar','exintegrante',0);
INSERT INTO personas VALUES(39,'Jack White',50,'The White Stripes','vocals, guitar','1975-07-09','exintegrante',1);
INSERT INTO personas VALUES(40,'Meg White',51,'The White Stripes','drums, vocals','1974-12-10','exintegrante',1);
INSERT INTO personas VALUES(41,'Mac DeMarco',36,'Mac DeMarco','Voz y multiinstrumentista','1990-04-30','integrante',1);
INSERT INTO personas VALUES(42,'Rob Waters',57,'Limp Bizkit','electric guitar','1968-08-26','exintegrante',0);
INSERT INTO personas VALUES(43,'John Otto',49,'Limp Bizkit','drums (drum set)','1977-03-22','integrante',1);
INSERT INTO personas VALUES(44,'Fred Durst',55,'Limp Bizkit','lead vocals','1970-08-20','integrante',1);
INSERT INTO personas VALUES(45,'Sam Rivers',48,'Limp Bizkit','background vocals, electric bass guitar','1977-09-02','integrante',1);
INSERT INTO personas VALUES(46,'Wes Borland',51,'Limp Bizkit','background vocals, electric guitar','1975-02-07','integrante',1);
INSERT INTO personas VALUES(47,'Terry Balsamo',53,'Limp Bizkit','guitar','1972-10-08','exintegrante',1);
INSERT INTO personas VALUES(48,'DJ Lethal',53,'Limp Bizkit','effects, sampler, turntable','1972-12-18','integrante',1);
INSERT INTO personas VALUES(49,'Head',55,'Limp Bizkit','electric guitar','1970-06-19','exintegrante',0);
INSERT INTO personas VALUES(50,'Mike Smith',52,'Limp Bizkit','electric guitar','1973-10-11','exintegrante',1);
INSERT INTO personas VALUES(51,'Sammy Siegler',0,'Limp Bizkit','drums (drum set)','Dato sin confirmar','exintegrante',0);
INSERT INTO personas VALUES(52,'Franko Carino',0,'Limp Bizkit','effects, sampler, turntable','Dato sin confirmar','exintegrante',0);
INSERT INTO personas VALUES(53,'Samuel G. Mpungu',0,'Limp Bizkit','electric bass guitar','Dato sin confirmar','exintegrante',0);
INSERT INTO personas VALUES(54,'Tsuzumi Okai',0,'Limp Bizkit','electric bass guitar','Dato sin confirmar','exintegrante',0);
INSERT INTO personas VALUES(55,'Ross Farrelly',29,'The Strypes','Voz, armonica','1996-10-31','exintegrante',1);
INSERT INTO personas VALUES(56,'Josh McClorey',30,'The Strypes','Guitarra, voz','1995-09-28','exintegrante',1);
INSERT INTO personas VALUES(57,'Pete O''Hanlon',30,'The Strypes','Bajo','1995-10-30','exintegrante',1);
INSERT INTO personas VALUES(58,'Evan Walsh',30,'The Strypes','Bateria','1996-03-17','exintegrante',1);
INSERT INTO personas VALUES(59,'Billy Bibby',0,'Catfish and the Bottlemen','guitar, backing vocals','Dato sin confirmar','exintegrante',1);
INSERT INTO personas VALUES(60,'Benji Blakeway',0,'Catfish and the Bottlemen','bass guitar, backing vocals','Dato sin confirmar','integrante',1);
INSERT INTO personas VALUES(61,'Van McCann',0,'Catfish and the Bottlemen','lead vocals, guitar','Dato sin confirmar','integrante',1);
INSERT INTO personas VALUES(62,'Bob Hall',0,'Catfish and the Bottlemen','drums','Dato sin confirmar','integrante',1);
INSERT INTO personas VALUES(63,'Johnny Bond',0,'Catfish and the Bottlemen','guitar, backing vocals','Dato sin confirmar','integrante',1);
CREATE TABLE albumes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombreAlbum TEXT NOT NULL,
            cancionMasPopular TEXT,
            fechaLanzamiento TEXT,
            grupo TEXT NOT NULL,
            generos TEXT,
            descripcion TEXT
        );
INSERT INTO albumes VALUES(1,'Currents','Let It Happen','2015-07-15','Tame Impala','5+ wochen, alternative, alternative pop, alternative r&b, dream pop','Album. Categoria: studio.');
INSERT INTO albumes VALUES(2,'Innerspeaker','It Is Not Meant To Be','2010-05-21','Tame Impala','garage psych, garage rock revival, indie rock, neo-psychedelia, psychedelic pop','Album. Categoria: studio.');
INSERT INTO albumes VALUES(5,'Deadbeat','Loser','2025-10-17','Tame Impala','5+ wochen, alternative pop, alternative rock, dance-pop, house','Album. Categoria: studio.');
INSERT INTO albumes VALUES(7,'Live At Lowlands, September 9, 2015','Let It Happen','2016-10-08','Tame Impala','alternative, alternative dance, alternative rock, alternative/indie rock, australia, australian','Album. Categoria: studio.');
INSERT INTO albumes VALUES(9,'Lonerism','Feels Like We Only Go Backwards','2012-10-05','Tame Impala','alternative/indie rock;indie rock;neo-psychedelia;pop/rock, indie rock, lo-fi, neo-psychedelia, psychedelic pop','Album. Categoria: studio.');
INSERT INTO albumes VALUES(11,'The Slow Rush','Borderline','2020-02-14','Tame Impala','balearic beat, indie rock, indietronica, neo-psychedelia, nu disco','Album. Categoria: studio.');
INSERT INTO albumes VALUES(12,'A Transparent Night','Let It Happen','2013','Tame Impala','psychedelic rock','Album. Categoria: studio.');
INSERT INTO albumes VALUES(32,'Humbug','Crying Lightning','2009-08-19','Arctic Monkeys','alternative, alternative rock, alternative/indie rock, garage rock revival, indie rock','Album. Categoria: studio.');
INSERT INTO albumes VALUES(33,'The Car','Body Paint','2022-10-21','Arctic Monkeys','alternative rock, art rock, baroque pop, chamber pop, glam rock','Album. Categoria: studio.');
INSERT INTO albumes VALUES(45,'Whatever People Say I Am, That’s What I’m Not','I Bet You Look Good On The Dancefloor','2005','Arctic Monkeys','alcohol, alternative, alternative & punk, alternative pop, alternative rock','Album. Categoria: studio.');
INSERT INTO albumes VALUES(54,'Tranquility Base Hotel & Casino','Anyways','2018-05-11','Arctic Monkeys','art rock, casino, glam rock, indie rock, lounge','Album. Categoria: studio.');
INSERT INTO albumes VALUES(57,'AM','Do I Wanna Know?','2013-01-01','Arctic Monkeys','alternative pop, alternative rock, alternative/indie rock, blues rock, indie rock','Album. Categoria: studio.');
INSERT INTO albumes VALUES(75,'Favourite Worst Nightmare','505','2007-04-18','Arctic Monkeys','alternative, alternative pop, alternative pop/rock, alternative punk, alternative rock','Album. Categoria: studio.');
INSERT INTO albumes VALUES(79,'Suck It and See','Evil Twin','2011-06-01','Arctic Monkeys','alternative pop/rock, alternative rock, indie rock, indie surf, jangle pop','Album. Categoria: studio.');
INSERT INTO albumes VALUES(90,'Humanz','She''s My Collar (feat. Kali Uchis)','2017-04-28','Gorillaz','alternative dance, conscious hip hop, electronic, electropop, hip hop','Album. Categoria: studio.');
INSERT INTO albumes VALUES(93,'Cracker Island','Tormenta (feat. Bad Bunny)','2023-02-24','Gorillaz','alternative dance, electronic, electropop, neo-psychedelia, quirky','Album. Categoria: studio.');
INSERT INTO albumes VALUES(101,'Gorillaz (album Sampler)','Feel Good Inc.','2000','Gorillaz','alternative dance, alternative rock, art pop, british, electronic, electronica','Album. Categoria: studio.');
INSERT INTO albumes VALUES(102,'The Now Now','Souk Eye','2018-06-29','Gorillaz','art pop, chillwave, electronic, electropop, neo-psychedelia','Album. Categoria: studio.');
INSERT INTO albumes VALUES(103,'Plastic Beach','On Melancholy Hill','2010-03-03','Gorillaz','alternative dance, alternative hip hop, alternative rock, art pop, chamber pop','Album. Categoria: studio.');
INSERT INTO albumes VALUES(112,'Gorillaz: Deep Cuts','Feel Good Inc.','2023','Gorillaz','alternative dance, alternative rock, art pop, british, electronic, electronica','Album. Categoria: studio.');
INSERT INTO albumes VALUES(114,'Gorillaz Live at KROQ','Feel Good Inc.','2018-10-18','Gorillaz','alternative dance, alternative rock, art pop, british, electronic, electronica','Album. Categoria: studio.');
INSERT INTO albumes VALUES(118,'Gorillaz','Clint Eastwood','2001-03-24','Gorillaz','abstract, alienation, alt, alternative, alternative & punk','Album. Categoria: studio.');
INSERT INTO albumes VALUES(119,'The Mountain','Orange County (feat. Bizarrap, Kara Jackson and Anoushka Shankar)','2026-02-27','Gorillaz','& country, 1–4 wochen, alternative pop, alternative/indie rock, art pop','Album. Categoria: studio.');
INSERT INTO albumes VALUES(120,'Song Machine, Season One: Strange Timez','Song Machine, Season One: Strange Timez','2020-10-23','Gorillaz','alternative dance, alternative hip hop, alternative r&b, art pop, dance-pop','Album. Categoria: studio.');
INSERT INTO albumes VALUES(122,'iSides','Feel Good Inc.','2010','Gorillaz','alternative dance, alternative rock, art pop, british, electronic, electronica','Album. Categoria: studio.');
INSERT INTO albumes VALUES(123,'The Fall','Revolving Doors','2010-12-25','Gorillaz','alternative hip-hop, alternative rock, downtempo, electronic, electropop','Album. Categoria: studio.');
INSERT INTO albumes VALUES(131,'Demon Days','Feel Good Inc.','2005-05-11','Gorillaz','alliteration, alternative, alternative and punk, alternative dance, alternative hip hop','Album. Categoria: studio.');
INSERT INTO albumes VALUES(143,'Emergency on Planet Earth','When You Gonna Learn?','1993-06-14','Jamiroquai','acid jazz, adult alternative pop/rock, electronic, funk, neo soul','Album. Categoria: studio.');
INSERT INTO albumes VALUES(154,'Travelling Without Moving','Virtual Insanity','1996-08-28','Jamiroquai','5+ wochen, acid jazz, adult alternative pop/rock, disco, electronic','Album. Categoria: studio.');
INSERT INTO albumes VALUES(155,'A Funk Odyssey','Little L','2001-08-29','Jamiroquai','acid jazz, adult alternative pop/rock, alt rock, dance-pop, disco','Album. Categoria: studio.');
INSERT INTO albumes VALUES(160,'Rock Dust Light Star','White Knuckle Ride','2010-10-29','Jamiroquai','acid jazz, alternative pop/rock, alternative/indie rock, club/dance, disco','Album. Categoria: studio.');
INSERT INTO albumes VALUES(164,'Automaton','Cloud 9','2017-03-31','Jamiroquai','dance-pop, electronic, funk, nu disco, pop','Album. Categoria: studio.');
INSERT INTO albumes VALUES(174,'Dynamite','Seven Days in Sunny June','2005-01-07','Jamiroquai','acid jazz, conscious, electro-disco, electronic, funk','Album. Categoria: studio.');
INSERT INTO albumes VALUES(183,'The Return of the Space Cowboy','Space Cowboy','1994-10-17','Jamiroquai','acid jazz, adult alternative pop/rock, alternative, electronic, free funk','Album. Categoria: studio.');
INSERT INTO albumes VALUES(184,'Synkronized','King for a Day','1999-06-07','Jamiroquai','acid jazz, adult alternative pop/rock, alternative, dance-pop, electronic','Album. Categoria: studio.');
INSERT INTO albumes VALUES(202,'De Stijl','Apple Blossom','2000-06-20','The White Stripes','alternative pop/rock, alternative rock, alternative/indie rock, blues rock, blues-rock','Album. Categoria: studio.');
INSERT INTO albumes VALUES(212,'Icky Thump','Icky Thump','2007-06-15','The White Stripes','alternative and punk, alternative pop/rock, alternative rock, alternative/indie rock, blues rock','Album. Categoria: studio.');
INSERT INTO albumes VALUES(231,'The White Stripes','St. James Infirmary Blues','1999-06-15','The White Stripes','alternative rock, alternative/indie rock, blues rock, blues-rock, garage rock','Album. Categoria: studio.');
INSERT INTO albumes VALUES(244,'Ellie','Seven Nation Army','2003','The White Stripes','2000''s, alternative rock, american, blues rock, detroit, garage punk','Album. Categoria: studio.');
INSERT INTO albumes VALUES(268,'White Blood Cells','We''re Going to Be Friends','2001-07-03','The White Stripes','1–4 wochen, alternative and punk, alternative rock, blues rock, garage rock revival','Album. Categoria: studio.');
INSERT INTO albumes VALUES(278,'Elephant','Seven Nation Army','2003-03-19','The White Stripes','alt rock, alternative and punk, alternative pop/rock, alternative rock, blues rock','Album. Categoria: studio.');
INSERT INTO albumes VALUES(281,'Get Behind Me Satan','Blue Orchid','2005-06-01','The White Stripes','alternative, alternative pop/rock, alternative rock, alternative/indie rock, blues rock','Album. Categoria: studio.');
INSERT INTO albumes VALUES(300,'2','Freaking Out the Neighborhood','2012-10-15','Mac DeMarco','bedroom pop, indie pop, indie rock, indie surf, jangle pop','Album. Categoria: studio.');
INSERT INTO albumes VALUES(301,'Seven Off the Two','Chamber of Reflection','2025-12-04','Mac DeMarco','folk pop, indie pop, indie rock, jangle pop, jizz jazz, lo-fi indie','Album. Categoria: studio.');
INSERT INTO albumes VALUES(302,'Dog on the Rock','Chamber of Reflection','2025-11-21','Mac DeMarco','bedroom pop, neo-psychedelia','Album. Categoria: studio.');
INSERT INTO albumes VALUES(305,'Guitar (Live On KEXP)','Chamber of Reflection','2025','Mac DeMarco','folk pop, indie pop, indie rock, jangle pop, jizz jazz, lo-fi indie','Album. Categoria: studio.');
INSERT INTO albumes VALUES(309,'Salad Days','Chamber Of Reflection','2014-04-01','Mac DeMarco','bedroom pop, hypnagogic pop, indie rock, indie surf, jangle pop','Album. Categoria: studio.');
INSERT INTO albumes VALUES(311,'Another One','No Other Heart','2015-08-07','Mac DeMarco','bedroom pop, indie rock, jangle pop, lo-fi, mini album','Album. Categoria: studio.');
INSERT INTO albumes VALUES(313,'Five Easy Hot Dogs','Vancouver 3','2023-01-20','Mac DeMarco','bedroom pop, indie rock, lounge, neo-psychedelia, psychedelic folk','Album. Categoria: studio.');
INSERT INTO albumes VALUES(314,'Here Comes the Cowboy','Heart To Heart','2019-05-10','Mac DeMarco','americana, bedroom pop, folk pop, indie folk, indie pop','Album. Categoria: studio.');
INSERT INTO albumes VALUES(315,'Guitar','Phantom','2025-08-22','Mac DeMarco','bedroom pop, english, indie folk, me 25–09, musikexpress.de','Album. Categoria: studio.');
INSERT INTO albumes VALUES(317,'This Old Dog','For the First Time','2017-05-05','Mac DeMarco','bedroom pop, folk pop, indie pop, indie rock, psychedelic pop','Album. Categoria: studio.');
INSERT INTO albumes VALUES(329,'Results May Vary','Lonely World','2003-05-28','Limp Bizkit','alternative & punk, alternative and punk, alternative metal, alternative punk, alternative rock','Album. Categoria: studio.');
INSERT INTO albumes VALUES(332,'Significant Other','Break Stuff','1999-06-18','Limp Bizkit','alternative and punk, alternative metal, funk metal, hard rock, heavy metal','Album. Categoria: studio.');
INSERT INTO albumes VALUES(334,'Three Dollar Bill, Yall$','Break Stuff','1997-06-24','Limp Bizkit','alternative metal, funk metal, hard rock, heavy alternative, heavy metal','Album. Categoria: studio.');
INSERT INTO albumes VALUES(335,'Still Sucks','Dirty Rotten Bizkit','2021-10-31','Limp Bizkit','1–4 wochen, alternative metal, alternative rock, hip hop, nu metal','Album. Categoria: studio.');
INSERT INTO albumes VALUES(343,'Chocolate Starfish and the Hot Dog Flavored Water','Rollin'' (Air Raid Vehicle)','2000-10-14','Limp Bizkit','alternative metal, alternative rock, english, funk metal, hip hop','Album. Categoria: studio.');
INSERT INTO albumes VALUES(350,'Gold Cobra','Gold Cobra','2011-06-24','Limp Bizkit','alternative metal, funk metal, heavy metal, nu metal, pop/rock','Album. Categoria: studio.');
INSERT INTO albumes VALUES(357,'Spitting Image','Behind Closed Doors','2017-06-16','The Strypes','blues rock, indie rock, rock, rock and roll','Album. Categoria: studio.');
INSERT INTO albumes VALUES(359,'Snapshot','What A Shame','2013-09-09','The Strypes','blues, blues rock, rock, rock and roll','Album. Categoria: studio.');
INSERT INTO albumes VALUES(360,'Little Victories','Get Into It','2015-07-15','The Strypes','blues, indie rock, rock','Album. Categoria: studio.');
INSERT INTO albumes VALUES(369,'The Balance','Longshot','2019-04-26','Catfish and the Bottlemen','alternative/indie, indie rock, rock','Album. Categoria: studio.');
INSERT INTO albumes VALUES(370,'The Ride','7','2016-05-27','Catfish and the Bottlemen','alternative/indie, indie rock, pop, rock','Album. Categoria: studio.');
INSERT INTO albumes VALUES(371,'The Balcony','Cocoon','2014-09-15','Catfish and the Bottlemen','indie rock, rock','Album. Categoria: studio.');
INSERT INTO sqlite_sequence VALUES('grupos',9);
INSERT INTO sqlite_sequence VALUES('personas',63);
INSERT INTO sqlite_sequence VALUES('albumes',374);
COMMIT;
