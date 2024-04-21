


CREATE DATABASE rohitLakshmiDeepikadatabase;






-- `usertype`

CREATE TABLE `usertype` (
  `UserTypeId` INT NOT NULL AUTO_INCREMENT,
  `UserTypeName` VARCHAR(50) NOT NULL,
  `CreatedDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`UserTypeId`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci



-- `propertytype`

CREATE TABLE `propertytype` (
  `PropertyTypeId` INT NOT NULL AUTO_INCREMENT,
  `PropertyTypeName` VARCHAR(50) NOT NULL,
  `CreatedDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`PropertyTypeId`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

-- `statedetails`

CREATE TABLE `statedetails` (
  `StateId` INT NOT NULL AUTO_INCREMENT,
  `StateName` VARCHAR(50) NOT NULL,
  `CreatedDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`StateId`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci


-- `citydetails`
CREATE TABLE `citydetails` (
  `CityId` INT NOT NULL AUTO_INCREMENT,
  `CityName` VARCHAR(50) NOT NULL,
  `StateId` INT DEFAULT NULL,
  `CreatedDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`CityId`),
  KEY `StateId` (`StateId`),
  CONSTRAINT `citydetails_ibfk_1` FOREIGN KEY (`StateId`) REFERENCES `statedetails` (`StateId`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci


-- `users`
CREATE TABLE `users` (
  `UserId` INT NOT NULL AUTO_INCREMENT,
  `UserName` VARCHAR(50) NOT NULL,
  `FirstName` VARCHAR(50) NOT NULL,
  `LastName` VARCHAR(50) DEFAULT NULL,
  `MiddleName` VARCHAR(50) DEFAULT NULL,
  `Password` VARCHAR(500) DEFAULT NULL,
  `UserTypeId` INT DEFAULT NULL,
  `MobileNumber` VARCHAR(20) NOT NULL,
  `CreatedDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`UserId`),
  KEY `UserTypeId` (`UserTypeId`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`UserTypeId`) REFERENCES `usertype` (`UserTypeId`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci


-- `propertydetails`


CREATE TABLE `propertydetails` (
  `PropertyId` INT NOT NULL AUTO_INCREMENT,
  `PropertyName` VARCHAR(50) NOT NULL,
  `Description` VARCHAR(500) DEFAULT NULL,
  `StateId` INT DEFAULT NULL,
  `CityId` INT DEFAULT NULL,
  `Price` DECIMAL(9,2) DEFAULT NULL,
  `PropertyTypeId` INT DEFAULT NULL,
  `Amenities` VARCHAR(1000) DEFAULT NULL,
  `AvailabilityDate` DATE DEFAULT NULL,
  `OwnerId` INT DEFAULT NULL,
  `FullAddress` VARCHAR(500) DEFAULT NULL,
  `Latitude` VARCHAR(30) DEFAULT NULL,
  `Longitude` VARCHAR(30) DEFAULT NULL,
  `IsApprovedByAdmin` TINYINT(1) NOT NULL DEFAULT '0',
  `CreatedDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`PropertyId`),
  KEY `StateId` (`StateId`),
  KEY `CityId` (`CityId`),
  KEY `PropertyTypeId` (`PropertyTypeId`),
  KEY `OwnerId` (`OwnerId`),
  CONSTRAINT `propertydetails_ibfk_1` FOREIGN KEY (`StateId`) REFERENCES `statedetails` (`StateId`),
  CONSTRAINT `propertydetails_ibfk_2` FOREIGN KEY (`CityId`) REFERENCES `citydetails` (`CityId`),
  CONSTRAINT `propertydetails_ibfk_3` FOREIGN KEY (`PropertyTypeId`) REFERENCES `propertytype` (`PropertyTypeId`),
  CONSTRAINT `propertydetails_ibfk_4` FOREIGN KEY (`OwnerId`) REFERENCES `users` (`UserId`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci



-- `propertyimages`

CREATE TABLE `propertyimages` (
  `PropertyImageId` INT NOT NULL AUTO_INCREMENT,
  `ImagePath` TEXT NOT NULL,
  `PropertyId` INT DEFAULT NULL,
  `CreatedDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`PropertyImageId`),
  KEY `PropertyId` (`PropertyId`),
  CONSTRAINT `propertyimages_ibfk_1` FOREIGN KEY (`PropertyId`) REFERENCES `propertydetails` (`PropertyId`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci


-- `bookappointment`

CREATE TABLE `bookappointment` (
  `BookAppointmentId` INT NOT NULL AUTO_INCREMENT,
  `CustomerId` INT NOT NULL,
  `PropertyId` INT DEFAULT NULL,
  `CreatedDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`BookAppointmentId`),
  KEY `PropertyId` (`PropertyId`),
  KEY `CustomerId` (`CustomerId`),
  CONSTRAINT `bookappointment_ibfk_1` FOREIGN KEY (`PropertyId`) REFERENCES `propertydetails` (`PropertyId`),
  CONSTRAINT `bookappointment_ibfk_2` FOREIGN KEY (`CustomerId`) REFERENCES `users` (`UserId`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci



-- `savedproperty`
CREATE TABLE `savedproperty` (
  `SavedPropertyId` INT NOT NULL AUTO_INCREMENT,
  `PropertyId` INT NOT NULL,
  `CustomerId` INT NOT NULL,
  `CreatedDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`SavedPropertyId`),
  KEY `PropertyId` (`PropertyId`),
  KEY `CustomerId` (`CustomerId`),
  CONSTRAINT `savedproperty_ibfk_1` FOREIGN KEY (`PropertyId`) REFERENCES `propertydetails` (`PropertyId`),
  CONSTRAINT `savedproperty_ibfk_2` FOREIGN KEY (`CustomerId`) REFERENCES `users` (`UserId`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci


-- `propertyrating`

CREATE TABLE `propertyrating` (
  `PropertyRatingId` INT NOT NULL AUTO_INCREMENT,
  `Rating` DECIMAL(9,1) NOT NULL,
  `Review` VARCHAR(500) DEFAULT NULL,
  `PropertyId` INT DEFAULT NULL,
  `CustomerId` INT DEFAULT NULL,
  `CreatedDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`PropertyRatingId`),
  KEY `PropertyId` (`PropertyId`),
  KEY `CustomerId` (`CustomerId`),
  CONSTRAINT `propertyrating_ibfk_1` FOREIGN KEY (`PropertyId`) REFERENCES `propertydetails` (`PropertyId`),
  CONSTRAINT `propertyrating_ibfk_2` FOREIGN KEY (`CustomerId`) REFERENCES `users` (`UserId`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci



SET FOREIGN_KEY_CHECKS =0;


-- insert 

/*Insert user type */

INSERT IGNORE INTO UserType (UserTypeName)
VALUES ('ADMIN'),('Home Owner'),('Customer');

INSERT IGNORE INTO PropertyType (PropertyTypeName)
VALUES
    ('3bhk'),
    ('2bhk'),
    ('studio')


/*Insert all state */
INSERT  IGNORE INTO StateDetails (StateName)
VALUES
    ('Alabama'),
    ('Alaska'),
    ('Arizona'),
    ('Arkansas'),
    ('California'),
    ('Colorado'),
    ('Connecticut'),
    ('Delaware'),
    ('Florida'),
    ('Georgia'),
    ('Hawaii'),
    ('Idaho'),
    ('Illinois'),
    ('Indiana'),
    ('Iowa'),
    ('Kansas'),
    ('Kentucky'),
    ('Louisiana'),
    ('Maine'),
    ('Maryland'),
    ('Massachusetts'),
    ('Michigan'),
    ('Minnesota'),
    ('Mississippi'),
    ('Missouri'),
    ('Montana'),
    ('Nebraska'),
    ('Nevada'),
    ('New Hampshire'),
    ('New Jersey'),
    ('New Mexico'),
    ('New York'),
    ('North Carolina'),
    ('North Dakota'),
    ('Ohio'),
    ('Oklahoma'),
    ('Oregon'),
    ('Pennsylvania'),
    ('Rhode Island'),
    ('South Carolina'),
    ('South Dakota'),
    ('Tennessee'),
    ('Texas'),
    ('Utah'),
    ('Vermont'),
    ('Virginia'),
    ('Washington'),
    ('West Virginia'),
    ('Wisconsin'),
    ('Wyoming');



-- Set the value of the variable based on StateName
SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Alabama');

-- Insert cities for Alabama (StateId = 1)
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Alexander City', @stateId),
    ('Andalusia', @stateId),
    ('Anniston', @stateId),
    ('Athens', @stateId),
    ('Atmore', @stateId),
    ('Auburn', @stateId),
    ('Bessemer', @stateId),
    ('Birmingham', @stateId),
    ('Chickasaw', @stateId),
    ('Clanton', @stateId),
    ('Cullman', @stateId),
    ('Decatur', @stateId),
    ('Demopolis', @stateId),
    ('Dothan', @stateId),
    ('Enterprise', @stateId),
    ('Eufaula', @stateId),
    ('Florence', @stateId),
    ('Fort Payne', @stateId),
    ('Gadsden', @stateId),
    ('Greenville', @stateId),
    ('Guntersville', @stateId),
    ('Huntsville', @stateId),
    ('Jasper', @stateId),
    ('Marion', @stateId),
    ('Mobile', @stateId),
    ('Montgomery', @stateId),
    ('Opelika', @stateId),
    ('Ozark', @stateId),
    ('Phenix City', @stateId),
    ('Prichard', @stateId),
    ('Scottsboro', @stateId),
    ('Selma', @stateId),
    ('Sheffield', @stateId),
    ('Sylacauga', @stateId),
    ('Talladega', @stateId),
    ('Troy', @stateId),
    ('Tuscaloosa', @stateId),
    ('Tuscumbia', @stateId),
    ('Tuskegee', @stateId);




-- Set the value of the variable based on StateName
SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Alaska');

-- Insert cities for Alabama (StateId = 1)
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Anchorage', @stateId),
    ('Cordova', @stateId),
    ('Fairbanks', @stateId),
    ('Haines', @stateId),
    ('Homer', @stateId),
    ('Juneau', @stateId),
    ('Ketchikan', @stateId),
    ('Kodiak', @stateId),
    ('Kotzebue', @stateId),
    ('Nome', @stateId),
    ('Palmer', @stateId),
    ('Seward', @stateId),
    ('Sitka', @stateId),
    ('Skagway', @stateId),
    ('Valdez', @stateId);


-- Set the value of the variable based on StateName
SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Arizona');

-- Insert cities for the specified state (e.g., Arizona, StateId = @stateId)
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Ajo', @stateId),
    ('Avondale', @stateId),
    ('Bisbee', @stateId),
    ('Casa Grande', @stateId),
    ('Chandler', @stateId),
    ('Clifton', @stateId),
    ('Douglas', @stateId),
    ('Flagstaff', @stateId),
    ('Florence', @stateId),
    ('Gila Bend', @stateId),
    ('Glendale', @stateId),
    ('Globe', @stateId),
    ('Kingman', @stateId),
    ('Lake Havasu City', @stateId),
    ('Mesa', @stateId),
    ('Nogales', @stateId),
    ('Oraibi', @stateId),
    ('Phoenix', @stateId),
    ('Prescott', @stateId),
    ('Scottsdale', @stateId),
    ('Sierra Vista', @stateId),
    ('Tempe', @stateId),
    ('Tombstone', @stateId),
    ('Tucson', @stateId),
    ('Walpi', @stateId),
    ('Window Rock', @stateId),
    ('Winslow', @stateId),
    ('Yuma', @stateId);
    
-- Set the value of the variable based on StateName
SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Arkansas');

-- Insert cities for the specified state (e.g., Arkansas, StateId = @stateId)
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Arkadelphia', @stateId),
    ('Arkansas Post', @stateId),
    ('Batesville', @stateId),
    ('Benton', @stateId),
    ('Blytheville', @stateId),
    ('Camden', @stateId),
    ('Conway', @stateId),
    ('Crossett', @stateId),
    ('El Dorado', @stateId),
    ('Fayetteville', @stateId),
    ('Forrest City', @stateId),
    ('Fort Smith', @stateId),
    ('Harrison', @stateId),
    ('Helena', @stateId),
    ('Hope', @stateId),
    ('Hot Springs', @stateId),
    ('Jacksonville', @stateId),
    ('Jonesboro', @stateId),
    ('Little Rock', @stateId),
    ('Magnolia', @stateId),
    ('Morrilton', @stateId),
    ('Newport', @stateId),
    ('North Little Rock', @stateId),
    ('Osceola', @stateId),
    ('Pine Bluff', @stateId),
    ('Rogers', @stateId),
    ('Searcy', @stateId),
    ('Stuttgart', @stateId),
    ('Van Buren', @stateId),
    ('West Memphis', @stateId);
    

SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'California');
-- Replace @stateId with the actual StateId
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Alameda', @stateId),
    ('Alhambra', @stateId),
    ('Anaheim', @stateId),
    ('Antioch', @stateId),
    ('Arcadia', @stateId),
    ('Bakersfield', @stateId),
    ('Barstow', @stateId),
    ('Belmont', @stateId),
    ('Berkeley', @stateId),
    ('Beverly Hills', @stateId),
    ('Brea', @stateId),
    ('Buena Park', @stateId),
    ('Burbank', @stateId),
    ('Calexico', @stateId),
    ('Calistoga', @stateId),
    ('Carlsbad', @stateId),
    ('Carmel', @stateId),
    ('Chico', @stateId),
    ('Chula Vista', @stateId),
    ('Claremont', @stateId),
    ('Compton', @stateId),
    ('Concord', @stateId),
    ('Corona', @stateId),
    ('Coronado', @stateId),
    ('Costa Mesa', @stateId),
    ('Culver City', @stateId),
    ('Daly City', @stateId),
    ('Davis', @stateId),
    ('Downey', @stateId),
    ('El Centro', @stateId),
    ('El Cerrito', @stateId),
    ('El Monte', @stateId),
    ('Escondido', @stateId),
    ('Eureka', @stateId),
    ('Fairfield', @stateId),
    ('Fontana', @stateId),
    ('Fremont', @stateId),
    ('Fresno', @stateId),
    ('Fullerton', @stateId),
    ('Garden Grove', @stateId),
    ('Glendale', @stateId),
    ('Hayward', @stateId),
    ('Hollywood', @stateId),
    ('Huntington Beach', @stateId),
    ('Indio', @stateId),
    ('Inglewood', @stateId),
    ('Irvine', @stateId),
    ('La Habra', @stateId),
    ('Laguna Beach', @stateId),
    ('Lancaster', @stateId),
    ('Livermore', @stateId),
    ('Lodi', @stateId),
    ('Lompoc', @stateId),
    ('Long Beach', @stateId),
    ('Los Angeles', @stateId),
    ('Malibu', @stateId),
    ('Martinez', @stateId),
    ('Marysville', @stateId),
    ('Menlo Park', @stateId),
    ('Merced', @stateId),
    ('Modesto', @stateId),
    ('Monterey', @stateId),
    ('Mountain View', @stateId),
    ('Napa', @stateId),
    ('Needles', @stateId),
    ('Newport Beach', @stateId),
    ('Norwalk', @stateId),
    ('Novato', @stateId),
    ('Oakland', @stateId),
    ('Oceanside', @stateId),
    ('Ojai', @stateId),
    ('Ontario', @stateId),
    ('Orange', @stateId),
    ('Oroville', @stateId),
    ('Oxnard', @stateId),
    ('Pacific Grove', @stateId),
    ('Palm Springs', @stateId),
    ('Palmdale', @stateId),
    ('Palo Alto', @stateId),
    ('Pasadena', @stateId),
    ('Petaluma', @stateId),
    ('Pomona', @stateId),
    ('Port Hueneme', @stateId),
    ('Rancho Cucamonga', @stateId),
    ('Red Bluff', @stateId),
    ('Redding', @stateId),
    ('Redlands', @stateId),
    ('Redondo Beach', @stateId),
    ('Redwood City', @stateId),
    ('Richmond', @stateId),
    ('Riverside', @stateId),
    ('Roseville', @stateId),
    ('Sacramento', @stateId),
    ('Salinas', @stateId),
    ('San Bernardino', @stateId),
    ('San Clemente', @stateId),
    ('San Diego', @stateId),
    ('San Fernando', @stateId),
    ('San Francisco', @stateId),
    ('San Gabriel', @stateId),
    ('San Jose', @stateId),
    ('San Juan Capistrano', @stateId),
    ('San Leandro', @stateId),
    ('San Luis Obispo', @stateId),
    ('San Marino', @stateId),
    ('San Mateo', @stateId),
    ('San Pedro', @stateId),
    ('San Rafael', @stateId),
    ('San Simeon', @stateId),
    ('Santa Ana', @stateId),
    ('Santa Barbara', @stateId),
    ('Santa Clara', @stateId),
    ('Santa Clarita', @stateId),
    ('Santa Cruz', @stateId),
    ('Santa Monica', @stateId),
    ('Santa Rosa', @state),
('Sausalito', @stateId),
    ('Simi Valley', @stateId),
    ('Sonoma', @stateId),
    ('South San Francisco', @stateId),
    ('Stockton', @stateId),
    ('Sunnyvale', @stateId),
    ('Susanville', @stateId),
    ('Thousand Oaks', @stateId),
    ('Torrance', @stateId),
    ('Turlock', @stateId),
    ('Ukiah', @stateId),
    ('Vallejo', @stateId),
    ('Ventura', @stateId),
    ('Victorville', @stateId),
    ('Visalia', @stateId),
    ('Walnut Creek', @stateId),
    ('Watts', @stateId),
    ('West Covina', @stateId),
    ('Whittier', @stateId),
    ('Woodland', @stateId),
    ('Yorba Linda', @stateId),
    ('Yuba City', @stateId);




SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Colorado');
-- Replace @stateId with the actual StateId
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Alamosa', @stateId),
    ('Aspen', @stateId),
    ('Aurora', @stateId),
    ('Boulder', @stateId),
    ('Breckenridge', @stateId),
    ('Brighton', @stateId),
    ('Canon City', @stateId),
    ('Central City', @stateId),
    ('Climax', @stateId),
    ('Colorado Springs', @stateId),
    ('Cortez', @stateId),
    ('Cripple Creek', @stateId),
    ('Denver', @stateId),
    ('Durango', @stateId),
    ('Englewood', @stateId),
    ('Estes Park', @stateId),
    ('Fort Collins', @stateId),
    ('Fort Morgan', @stateId),
    ('Georgetown', @stateId),
    ('Glenwood Springs', @stateId),
    ('Golden', @stateId),
    ('Grand Junction', @stateId),
    ('Greeley', @stateId),
    ('Gunnison', @stateId),
    ('La Junta', @stateId),
    ('Leadville', @stateId),
    ('Littleton', @stateId),
    ('Longmont', @stateId),
    ('Loveland', @stateId),
    ('Montrose', @stateId),
    ('Ouray', @stateId),
    ('Pagosa Springs', @stateId),
    ('Pueblo', @stateId),
    ('Silverton', @stateId),
    ('Steamboat Springs', @stateId),
    ('Sterling', @stateId),
    ('Telluride', @stateId),
    ('Trinidad', @stateId),
    ('Vail', @stateId),
    ('Walsenburg', @stateId),
    ('Westminster', @stateId);
    
    SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Connecticut');
-- Replace @stateId with the actual StateId

-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Ansonia', @stateId),
    ('Berlin', @stateId),
    ('Bloomfield', @stateId),
    ('Branford', @stateId),
    ('Bridgeport', @stateId),
    ('Bristol', @stateId),
    ('Coventry', @stateId),
    ('Danbury', @stateId),
    ('Darien', @stateId),
    ('Derby', @stateId),
    ('East Hartford', @stateId),
    ('East Haven', @stateId),
    ('Enfield', @stateId),
    ('Fairfield', @stateId),
    ('Farmington', @stateId),
    ('Greenwich', @stateId),
    ('Groton', @stateId),
    ('Guilford', @stateId),
    ('Hamden', @stateId),
    ('Hartford', @stateId),
    ('Lebanon', @stateId),
    ('Litchfield', @stateId),
    ('Manchester', @stateId),
    ('Mansfield', @stateId),
    ('Meriden', @stateId),
    ('Middletown', @stateId),
    ('Milford', @stateId),
    ('Mystic', @stateId),
    ('Naugatuck', @stateId),
    ('New Britain', @stateId),
    ('New Haven', @stateId),
    ('New London', @stateId),
    ('North Haven', @stateId),
    ('Norwalk', @stateId),
    ('Norwich', @stateId),
    ('Old Saybrook', @stateId),
    ('Orange', @stateId),
    ('Seymour', @stateId),
    ('Shelton', @stateId),
    ('Simsbury', @stateId),
    ('Southington', @stateId),
    ('Stamford', @stateId),
    ('Stonington', @stateId),
    ('Stratford', @stateId),
    ('Torrington', @stateId),
    ('Wallingford', @stateId),
    ('Waterbury', @stateId),
    ('Waterford', @stateId),
    ('Watertown', @stateId),
    ('West Hartford', @stateId),
    ('West Haven', @stateId),
    ('Westport', @stateId),
    ('Wethersfield', @stateId),
    ('Willimantic', @stateId),
    ('Windham', @stateId),
    ('Windsor', @stateId),
    ('Windsor Locks', @stateId),
    ('Winsted', @stateId);


    SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Delaware');
    INSERT INTO CityDetails (CityName, StateId)
   VALUES
    ('Dover', @stateId),
    ('Lewes', @stateId),
    ('Milford', @stateId),
    ('New Castle', @stateId),
    ('Newark', @stateId),
    ('Smyrna', @stateId),
    ('Wilmington', @stateId);
    
SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Florida');
        -- Replace @stateId with the actual StateId

-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Apalachicola', @stateId),
    ('Bartow', @stateId),
    ('Belle Glade', @stateId),
    ('Boca Raton', @stateId),
    ('Bradenton', @stateId),
    ('Cape Coral', @stateId),
    ('Clearwater', @stateId),
    ('Cocoa Beach', @stateId),
    ('Cocoa-Rockledge', @stateId),
    ('Coral Gables', @stateId),
    ('Daytona Beach', @stateId),
    ('De Land', @stateId),
    ('Deerfield Beach', @stateId),
    ('Delray Beach', @stateId),
    ('Fernandina Beach', @stateId),
    ('Fort Lauderdale', @stateId),
    ('Fort Myers', @stateId),
    ('Fort Pierce', @stateId),
    ('Fort Walton Beach', @stateId),
    ('Gainesville', @stateId),
    ('Hallandale Beach', @stateId),
    ('Hialeah', @stateId),
    ('Hollywood', @stateId),
    ('Homestead', @stateId),
    ('Jacksonville', @stateId),
    ('Key West', @stateId),
    ('Lake City', @stateId),
    ('Lake Wales', @stateId),
    ('Lakeland', @stateId),
    ('Largo', @stateId),
    ('Melbourne', @stateId),
    ('Miami', @stateId),
    ('Miami Beach', @stateId),
    ('Naples', @stateId),
    ('New Smyrna Beach', @stateId),
    ('Ocala', @stateId),
    ('Orlando', @stateId),
    ('Ormond Beach', @stateId),
    ('Palatka', @stateId),
    ('Palm Bay', @stateId),
    ('Palm Beach', @stateId),
    ('Panama City', @stateId),
    ('Pensacola', @stateId),
    ('Pompano Beach', @stateId),
    ('Saint Augustine', @stateId),
    ('Saint Petersburg', @stateId),
    ('Sanford', @stateId),
    ('Sarasota', @stateId),
    ('Sebring', @stateId),
    ('Tallahassee', @stateId),
    ('Tampa', @stateId),
    ('Tarpon Springs', @stateId),
    ('Titusville', @stateId),
    ('Venice', @stateId),
    ('West Palm Beach', @stateId),
    ('White Springs', @stateId),
    ('Winter Haven', @stateId),
    ('Winter Park', @stateId);


SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Georgia');
-- Replace @stateId with the actual StateId

-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Albany', @stateId),
    ('Americus', @stateId),
    ('Andersonville', @stateId),
    ('Athens', @stateId),
    ('Atlanta', @stateId),
    ('Augusta', @stateId),
    ('Bainbridge', @stateId),
    ('Blairsville', @stateId),
    ('Brunswick', @stateId),
    ('Calhoun', @stateId),
    ('Carrollton', @stateId),
    ('Columbus', @stateId),
    ('Dahlonega', @stateId),
    ('Dalton', @stateId),
    ('Darien', @stateId),
    ('Decatur', @stateId),
    ('Douglas', @stateId),
    ('East Point', @stateId),
    ('Fitzgerald', @stateId),
    ('Fort Valley', @stateId),
    ('Gainesville', @stateId),
    ('La Grange', @stateId),
    ('Macon', @stateId),
    ('Marietta', @stateId),
    ('Milledgeville', @stateId),
    ('Plains', @stateId),
    ('Rome', @stateId),
    ('Savannah', @stateId),
    ('Toccoa', @stateId),
    ('Valdosta', @stateId),
    ('Warm Springs', @stateId),
    ('Warner Robins', @stateId),
    ('Washington', @stateId),
    ('Waycross', @stateId);


SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Hawaii');

-- Replace @stateId with the actual StateId

-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Hanalei', @stateId),
    ('Hilo', @stateId),
    ('Honaunau', @stateId),
    ('Honolulu', @stateId),
    ('Kahului', @stateId),
    ('Kaneohe', @stateId),
    ('Kapaa', @stateId),
    ('Kawaihae', @stateId),
    ('Lahaina', @stateId),
    ('Laie', @stateId),
    ('Wahiawa', @stateId),
    ('Wailuku', @stateId),
    ('Waimea', @stateId);



SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Idaho');

-- Replace @stateId with the actual StateId

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Blackfoot', @stateId),
    ('Boise', @stateId),
    ('Bonners Ferry', @stateId),
    ('Caldwell', @stateId),
    ('Coeur d''Alene', @stateId),
    ('Idaho City', @stateId),
    ('Idaho Falls', @stateId),
    ('Kellogg', @stateId),
    ('Lewiston', @stateId),
    ('Moscow', @stateId),
    ('Nampa', @stateId),
    ('Pocatello', @stateId),
    ('Priest River', @stateId),
    ('Rexburg', @stateId),
    ('Sun Valley', @stateId),
    ('Twin Falls', @stateId);


SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Illinois');

-- Replace @stateId with the actual StateId

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Alton', @stateId),
    ('Arlington Heights', @stateId),
    ('Arthur', @stateId),
    ('Aurora', @stateId),
    ('Belleville', @stateId),
    ('Belvidere', @stateId),
    ('Bloomington', @stateId),
    ('Brookfield', @stateId),
    ('Cahokia', @stateId),
    ('Cairo', @stateId),
    ('Calumet City', @stateId),
    ('Canton', @stateId),
    ('Carbondale', @stateId),
    ('Carlinville', @stateId),
    ('Carthage', @stateId),
    ('Centralia', @stateId),
    ('Champaign', @stateId),
    ('Charleston', @stateId),
    ('Chester', @stateId),
    ('Chicago', @stateId),
    ('Chicago Heights', @stateId),
    ('Cicero', @stateId),
    ('Collinsville', @stateId),
    ('Danville', @stateId),
    ('Decatur', @stateId),
    ('DeKalb', @stateId),
    ('Des Plaines', @stateId),
    ('Dixon', @stateId),
    ('East Moline', @stateId),
    ('East Saint Louis', @stateId),
    ('Effingham', @stateId),
    ('Elgin', @stateId),
    ('Elmhurst', @stateId),
    ('Evanston', @stateId),
    ('Freeport', @stateId),
    ('Galena', @stateId),
    ('Galesburg', @stateId),
    ('Glen Ellyn', @stateId),
    ('Glenview', @stateId),
    ('Granite City', @stateId),
    ('Harrisburg', @stateId),
    ('Herrin', @stateId),
    ('Highland Park', @stateId),
    ('Jacksonville', @stateId),
    ('Joliet', @stateId),
    ('Kankakee', @stateId),
    ('Kaskaskia', @stateId),
    ('Kewanee', @stateId),
    ('La Salle', @stateId),
    ('Lake Forest', @stateId),
    ('Libertyville', @stateId),
    ('Lincoln', @stateId),
    ('Lisle', @stateId),
    ('Lombard', @stateId),
    ('Macomb', @stateId),
    ('Mattoon', @stateId),
    ('Moline', @stateId),
    ('Monmouth', @stateId),
    ('Mount Vernon', @stateId),
    ('Mundelein', @stateId),
    ('Naperville', @stateId),
    ('Nauvoo', @stateId),
    ('Normal', @stateId),
    ('North Chicago', @stateId),
    ('Oak Park', @stateId),
    ('Oregon', @stateId),
    ('Ottawa', @stateId),
    ('Palatine', @stateId),
    ('Park Forest', @stateId),
    ('Park Ridge', @stateId),
    ('Pekin', @stateId),
    ('Peoria', @stateId),
    ('Petersburg', @stateId),
    ('Pontiac', @stateId),
    ('Quincy', @stateId),
    ('Rantoul', @stateId),
    ('River Forest', @stateId),
    ('Rock Island', @stateId),
    ('Rockford', @stateId),
    ('Salem', @stateId),
    ('Shawneetown', @stateId),
    ('Skokie', @stateId),
    ('South Holland', @stateId),
    ('Springfield', @stateId),
    ('Streator', @stateId),
    ('Summit', @stateId),
    ('Urbana', @stateId),
    ('Vandalia', @stateId),
    ('Virden', @stateId),
    ('Waukegan', @stateId),
    ('Wheaton', @stateId),
    ('Wilmette', @stateId),
    ('Winnetka', @stateId),
    ('Wood River', @stateId),
    ('Zion', @stateId);


SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Indiana');
-- Replace @stateId with the actual StateId

-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Anderson', @stateId),
    ('Bedford', @stateId),
    ('Bloomington', @stateId),
    ('Columbus', @stateId),
    ('Connersville', @stateId),
    ('Corydon', @stateId),
    ('Crawfordsville', @stateId),
    ('East Chicago', @stateId),
    ('Elkhart', @stateId),
    ('Elwood', @stateId),
    ('Evansville', @stateId),
    ('Fort Wayne', @stateId),
    ('French Lick', @stateId),
    ('Gary', @stateId),
    ('Geneva', @stateId),
    ('Goshen', @stateId),
    ('Greenfield', @stateId),
    ('Hammond', @stateId),
    ('Hobart', @stateId),
    ('Huntington', @stateId),
    ('Indianapolis', @stateId),
    ('Jeffersonville', @stateId),
    ('Kokomo', @stateId),
    ('Lafayette', @stateId),
    ('Madison', @stateId),
    ('Marion', @stateId),
    ('Michigan City', @stateId),
    ('Mishawaka', @stateId),
    ('Muncie', @stateId),
    ('Nappanee', @stateId),
    ('Nashville', @stateId),
    ('New Albany', @stateId),
    ('New Castle', @stateId),
    ('New Harmony', @stateId),
    ('Peru', @stateId),
    ('Plymouth', @stateId),
    ('Richmond', @stateId),
    ('Santa Claus', @stateId),
    ('Shelbyville', @stateId),
    ('South Bend', @stateId),
    ('Terre Haute', @stateId),
    ('Valparaiso', @stateId),
    ('Vincennes', @stateId),
    ('Wabash', @stateId),
    ('West Lafayette', @stateId);
    
    SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Iowa');
    
    -- Replace @stateId with the actual StateId

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Amana Colonies', @stateId),
    ('Ames', @stateId),
    ('Boone', @stateId),
    ('Burlington', @stateId),
    ('Cedar Falls', @stateId),
    ('Cedar Rapids', @stateId),
    ('Charles City', @stateId),
    ('Cherokee', @stateId),
    ('Clinton', @stateId),
    ('Council Bluffs', @stateId),
    ('Davenport', @stateId),
    ('Des Moines', @stateId),
    ('Dubuque', @stateId),
    ('Estherville', @stateId),
    ('Fairfield', @stateId),
    ('Fort Dodge', @stateId),
    ('Grinnell', @stateId),
    ('Indianola', @stateId),
    ('Iowa City', @stateId),
    ('Keokuk', @stateId),
    ('Mason City', @stateId),
    ('Mount Pleasant', @stateId),
    ('Muscatine', @stateId),
    ('Newton', @stateId),
    ('Oskaloosa', @stateId),
    ('Ottumwa', @stateId),
    ('Sioux City', @stateId),
    ('Waterloo', @stateId),
    ('Webster City', @stateId),
    ('West Des Moines', @stateId);
    
    
    SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Kansas');

-- Replace @stateId with the actual StateId

-- Set the state ID

-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Abilene', @stateId),
    ('Arkansas City', @stateId),
    ('Atchison', @stateId),
    ('Chanute', @stateId),
    ('Coffeyville', @stateId),
    ('Council Grove', @stateId),
    ('Dodge City', @stateId),
    ('Emporia', @stateId),
    ('Fort Scott', @stateId),
    ('Garden City', @stateId),
    ('Great Bend', @stateId),
    ('Hays', @stateId),
    ('Hutchinson', @stateId),
    ('Independence', @stateId),
    ('Junction City', @stateId),
    ('Kansas City', @stateId),
    ('Lawrence', @stateId),
    ('Leavenworth', @stateId),
    ('Liberal', @stateId),
    ('Manhattan', @stateId),
    ('McPherson', @stateId),
    ('Medicine Lodge', @stateId),
    ('Newton', @stateId),
    ('Olathe', @stateId),
    ('Osawatomie', @stateId),
    ('Ottawa', @stateId),
    ('Overland Park', @stateId),
    ('Pittsburg', @stateId),
    ('Salina', @stateId),
    ('Shawnee', @stateId),
    ('Smith Center', @stateId),
    ('Topeka', @stateId),
    ('Wichita', @stateId);


    SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Kentucky');
-- Replace @stateId with the actual StateId

-- Set the state ID

-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Ashland', @stateId),
    ('Barbourville', @stateId),
    ('Bardstown', @stateId),
    ('Berea', @stateId),
    ('Boonesborough', @stateId),
    ('Bowling Green', @stateId),
    ('Campbellsville', @stateId),
    ('Covington', @stateId),
    ('Danville', @stateId),
    ('Elizabethtown', @stateId),
    ('Frankfort', @stateId),
    ('Harlan', @stateId),
    ('Harrodsburg', @stateId),
    ('Hazard', @stateId),
    ('Henderson', @stateId),
    ('Hodgenville', @stateId),
    ('Hopkinsville', @stateId),
    ('Lexington', @stateId),
    ('Louisville', @stateId),
    ('Mayfield', @stateId),
    ('Maysville', @stateId),
    ('Middlesboro', @stateId),
    ('Newport', @stateId),
    ('Owensboro', @stateId),
    ('Paducah', @stateId),
    ('Paris', @stateId),
    ('Richmond', @stateId);

    SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Louisiana');
    
    -- Replace @stateId with the actual StateId
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Abbeville', @stateId),
    ('Alexandria', @stateId),
    ('Bastrop', @stateId),
    ('Baton Rouge', @stateId),
    ('Bogalusa', @stateId),
    ('Bossier City', @stateId),
    ('Gretna', @stateId),
    ('Houma', @stateId),
    ('Lafayette', @stateId),
    ('Lake Charles', @stateId),
    ('Monroe', @stateId),
    ('Morgan City', @stateId),
    ('Natchitoches', @stateId),
    ('New Iberia', @stateId),
    ('New Orleans', @stateId),
    ('Opelousas', @stateId),
    ('Ruston', @stateId),
    ('Saint Martinville', @stateId),
    ('Shreveport', @stateId),
    ('Thibodaux', @stateId);
    
    SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Maine');
    -- Replace @stateId with the actual StateId

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Auburn', @stateId),
    ('Augusta', @stateId),
    ('Bangor', @stateId),
    ('Bar Harbor', @stateId),
    ('Bath', @stateId),
    ('Belfast', @stateId),
    ('Biddeford', @stateId),
    ('Boothbay Harbor', @stateId),
    ('Brunswick', @stateId),
    ('Calais', @stateId),
    ('Caribou', @stateId),
    ('Castine', @stateId),
    ('Eastport', @stateId),
    ('Ellsworth', @stateId),
    ('Farmington', @stateId),
    ('Fort Kent', @stateId),
    ('Gardiner', @stateId),
    ('Houlton', @stateId),
    ('Kennebunkport', @stateId),
    ('Kittery', @stateId),
    ('Lewiston', @stateId),
    ('Lubec', @stateId),
    ('Machias', @stateId),
    ('Orono', @stateId),
    ('Portland', @stateId),
    ('Presque Isle', @stateId),
    ('Rockland', @stateId),
    ('Rumford', @stateId),
    ('Saco', @stateId),
    ('Scarborough', @stateId),
    ('Waterville', @stateId),
    ('York', @stateId);
    
SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Maryland');
-- Replace @stateId with the actual StateId

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Aberdeen', @stateId),
    ('Annapolis', @stateId),
    ('Baltimore', @stateId),
    ('Bethesda-Chevy Chase', @stateId),
    ('Bowie', @stateId),
    ('Cambridge', @stateId),
    ('Catonsville', @stateId),
    ('College Park', @stateId),
    ('Columbia', @stateId),
    ('Cumberland', @stateId),
    ('Easton', @stateId),
    ('Elkton', @stateId),
    ('Emmitsburg', @stateId),
    ('Frederick', @stateId),
    ('Greenbelt', @stateId),
    ('Hagerstown', @stateId),
    ('Hyattsville', @stateId),
    ('Laurel', @stateId),
    ('Oakland', @stateId),
    ('Ocean City', @stateId),
    ('Rockville', @stateId),
    ('Saint Marys City', @stateId),
    ('Salisbury', @stateId),
    ('Silver Spring', @stateId),
    ('Takoma Park', @stateId),
    ('Towson', @stateId),
    ('Westminster', @stateId);




SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Massachusetts');

-- Replace @stateId with the actual StateId

-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Abington', @stateId),
    ('Adams', @stateId),
    ('Amesbury', @stateId),
    ('Amherst', @stateId),
    ('Andover', @stateId),
    ('Arlington', @stateId),
    ('Athol', @stateId),
    ('Attleboro', @stateId),
    ('Barnstable', @stateId),
    ('Bedford', @stateId),
    ('Beverly', @stateId),
    ('Boston', @stateId),
    ('Bourne', @stateId),
    ('Braintree', @stateId),
    ('Brockton', @stateId),
    ('Brookline', @stateId),
    ('Cambridge', @stateId),
    ('Canton', @stateId),
    ('Charlestown', @stateId),
    ('Chelmsford', @stateId),
    ('Chelsea', @stateId),
    ('Chicopee', @stateId),
    ('Clinton', @stateId),
    ('Cohasset', @stateId),
    ('Concord', @stateId),
    ('Danvers', @stateId),
    ('Dartmouth', @stateId),
    ('Dedham', @stateId),
    ('Dennis', @stateId),
    ('Duxbury', @stateId),
    ('Eastham', @stateId),
    ('Edgartown', @stateId),
    ('Everett', @stateId),
    ('Fairhaven', @stateId),
    ('Fall River', @stateId),
    ('Falmouth', @stateId),
    ('Fitchburg', @stateId),
    ('Framingham', @stateId),
    ('Gloucester', @stateId),
    ('Great Barrington', @stateId),
    ('Greenfield', @stateId),
    ('Groton', @stateId),
    ('Harwich', @stateId),
    ('Haverhill', @stateId),
    ('Hingham', @stateId),
    ('Holyoke', @stateId),
    ('Hyannis', @stateId),
    ('Ipswich', @stateId),
    ('Lawrence', @stateId),
    ('Lenox', @stateId),
    ('Leominster', @stateId),
    ('Lexington', @stateId),
    ('Lowell', @stateId),
    ('Ludlow', @stateId),
    ('Lynn', @stateId),
    ('Malden', @stateId),
    ('Marblehead', @stateId),
    ('Marlborough', @stateId),
    ('Medford', @stateId),
    ('Milton', @stateId),
    ('Nahant', @stateId),
    ('Natick', @stateId),
    ('New Bedford', @stateId),
    ('Newburyport', @stateId),
    ('Newton', @stateId),
    ('North Adams', @stateId),
    ('Northampton', @stateId),
    ('Norton', @stateId),
    ('Norwood', @stateId),
    ('Peabody', @stateId),
    ('Pittsfield', @stateId),
    ('Plymouth', @stateId),
    ('Provincetown', @stateId),
    ('Quincy', @stateId),
    ('Randolph', @stateId),
    ('Revere', @stateId),
    ('Salem', @stateId),
    ('Sandwich', @stateId),
    ('Saugus', @stateId),
    ('Somerville', @stateId),
    ('South Hadley', @stateId),
    ('Springfield', @stateId),
    ('Stockbridge', @stateId),
    ('Stoughton', @stateId),
    ('Sturbridge', @stateId),
    ('Sudbury', @stateId),
    ('Taunton', @stateId),
    ('Tewksbury', @stateId),
    ('Truro', @stateId),
    ('Watertown', @stateId),
    ('Webster', @stateId),
    ('Wellesley', @stateId),
    ('Wellfleet', @stateId),
    ('West Bridgewater', @stateId),
    ('West Springfield', @stateId),
    ('Westfield', @stateId),
    ('Weymouth', @stateId),
    ('Whitman', @stateId),
    ('Williamstown', @stateId),
    ('Woburn', @stateId),
    ('Woods Hole', @stateId),
    ('Worcester', @stateId);
    
    
    SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Michigan');
    -- Replace @stateId with the actual StateId

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Adrian', @stateId),
    ('Alma', @stateId),
    ('Ann Arbor', @stateId),
    ('Battle Creek', @stateId),
    ('Bay City', @stateId),
    ('Benton Harbor', @stateId),
    ('Bloomfield Hills', @stateId),
    ('Cadillac', @stateId),
    ('Charlevoix', @stateId),
    ('Cheboygan', @stateId),
    ('Dearborn', @stateId),
    ('Detroit', @stateId),
    ('East Lansing', @stateId),
    ('Eastpointe', @stateId),
    ('Ecorse', @stateId),
    ('Escanaba', @stateId),
    ('Flint', @stateId),
    ('Grand Haven', @stateId),
    ('Grand Rapids', @stateId),
    ('Grayling', @stateId),
    ('Grosse Pointe', @stateId),
    ('Hancock', @stateId),
    ('Highland Park', @stateId),
    ('Holland', @stateId),
    ('Houghton', @stateId),
    ('Interlochen', @stateId),
    ('Iron Mountain', @stateId),
    ('Ironwood', @stateId),
    ('Ishpeming', @stateId),
    ('Jackson', @stateId),
    ('Kalamazoo', @stateId),
    ('Lansing', @stateId),
    ('Livonia', @stateId),
    ('Ludington', @stateId),
    ('Mackinaw City', @stateId),
    ('Manistee', @stateId),
    ('Marquette', @stateId),
    ('Menominee', @stateId),
    ('Midland', @stateId),
    ('Monroe', @stateId),
    ('Mount Clemens', @stateId),
    ('Mount Pleasant', @stateId),
    ('Muskegon', @stateId),
    ('Niles', @stateId),
    ('Petoskey', @stateId),
    ('Pontiac', @stateId),
    ('Port Huron', @stateId),
    ('Royal Oak', @stateId),
    ('Saginaw', @stateId),
    ('Saint Ignace', @stateId),
    ('Saint Joseph', @stateId),
    ('Sault Sainte Marie', @stateId),
    ('Traverse City', @stateId),
    ('Trenton', @stateId),
    ('Warren', @stateId),
    ('Wyandotte', @stateId),
    ('Ypsilanti', @stateId);

    SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Minnesota');
    
    -- Replace @stateId with the actual StateId

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Albert Lea', @stateId),
    ('Alexandria', @stateId),
    ('Austin', @stateId),
    ('Bemidji', @stateId),
    ('Bloomington', @stateId),
    ('Brainerd', @stateId),
    ('Crookston', @stateId),
    ('Duluth', @stateId),
    ('Ely', @stateId),
    ('Eveleth', @stateId),
    ('Faribault', @stateId),
    ('Fergus Falls', @stateId),
    ('Hastings', @stateId),
    ('Hibbing', @stateId),
    ('International Falls', @stateId),
    ('Little Falls', @stateId),
    ('Mankato', @stateId),
    ('Minneapolis', @stateId),
    ('Moorhead', @stateId),
    ('New Ulm', @stateId),
    ('Northfield', @stateId),
    ('Owatonna', @stateId),
    ('Pipestone', @stateId),
    ('Red Wing', @stateId),
    ('Rochester', @stateId),
    ('Saint Cloud', @stateId),
    ('Saint Paul', @stateId),
    ('Sauk Centre', @stateId),
    ('South Saint Paul', @stateId),
    ('Stillwater', @stateId),
    ('Virginia', @stateId),
    ('Willmar', @stateId),
    ('Winona', @stateId);


    SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Mississippi');
    -- Replace @stateId with the actual StateId

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Albert Lea', @stateId),
    ('Alexandria', @stateId),
    ('Austin', @stateId),
    ('Bemidji', @stateId),
    ('Bloomington', @stateId),
    ('Brainerd', @stateId),
    ('Crookston', @stateId),
    ('Duluth', @stateId),
    ('Ely', @stateId),
    ('Eveleth', @stateId),
    ('Faribault', @stateId),
    ('Fergus Falls', @stateId),
    ('Hastings', @stateId),
    ('Hibbing', @stateId),
    ('International Falls', @stateId),
    ('Little Falls', @stateId),
    ('Mankato', @stateId),
    ('Minneapolis', @stateId),
    ('Moorhead', @stateId),
    ('New Ulm', @stateId),
    ('Northfield', @stateId),
    ('Owatonna', @stateId),
    ('Pipestone', @stateId),
    ('Red Wing', @stateId),
    ('Rochester', @stateId),
    ('Saint Cloud', @stateId),
    ('Saint Paul', @stateId),
    ('Sauk Centre', @stateId),
    ('South Saint Paul', @stateId),
    ('Stillwater', @stateId),
    ('Virginia', @stateId),
    ('Willmar', @stateId),
    ('Winona', @stateId);


    SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Missouri');
    -- Replace @stateId with the actual StateId

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Boonville', @stateId),
    ('Branson', @stateId),
    ('Cape Girardeau', @stateId),
    ('Carthage', @stateId),
    ('Chillicothe', @stateId),
    ('Clayton', @stateId),
    ('Columbia', @stateId),
    ('Excelsior Springs', @stateId),
    ('Ferguson', @stateId),
    ('Florissant', @stateId),
    ('Fulton', @stateId),
    ('Hannibal', @stateId),
    ('Independence', @stateId),
    ('Jefferson City', @stateId),
    ('Joplin', @stateId),
    ('Kansas City', @stateId),
    ('Kirksville', @stateId),
    ('Lamar', @stateId),
    ('Lebanon', @stateId),
    ('Lexington', @stateId),
    ('Maryville', @stateId),
    ('Mexico', @stateId),
    ('Monett', @stateId),
    ('Neosho', @stateId),
    ('New Madrid', @stateId),
    ('Rolla', @stateId),
    ('Saint Charles', @stateId),
    ('Saint Joseph', @stateId),
    ('Saint Louis', @stateId),
    ('Sainte Genevieve', @stateId),
    ('Salem', @stateId),
    ('Sedalia', @stateId),
    ('Springfield', @stateId),
    ('Warrensburg', @stateId),
    ('West Plains', @stateId);


    SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Montana');
    -- Replace @stateId with the actual StateId

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Anaconda', @stateId),
    ('Billings', @stateId),
    ('Bozeman', @stateId),
    ('Butte', @stateId),
    ('Dillon', @stateId),
    ('Fort Benton', @stateId),
    ('Glendive', @stateId),
    ('Great Falls', @stateId),
    ('Havre', @stateId),
    ('Helena', @stateId),
    ('Kalispell', @stateId),
    ('Lewistown', @stateId),
    ('Livingston', @stateId),
    ('Miles City', @stateId),
    ('Missoula', @stateId),
    ('Virginia City', @stateId);

SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Nebraska');

-- Replace @stateId with the actual StateId

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Beatrice', @stateId),
    ('Bellevue', @stateId),
    ('Boys Town', @stateId),
    ('Chadron', @stateId),
    ('Columbus', @stateId),
    ('Fremont', @stateId),
    ('Grand Island', @stateId),
    ('Hastings', @stateId),
    ('Kearney', @stateId),
    ('Lincoln', @stateId),
    ('McCook', @stateId),
    ('Minden', @stateId),
    ('Nebraska City', @stateId),
    ('Norfolk', @stateId),
    ('North Platte', @stateId),
    ('Omaha', @stateId),
    ('Plattsmouth', @stateId),
    ('Red Cloud', @stateId),
    ('Sidney', @stateId);

SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Nevada');
-- Replace @stateId with the actual StateId

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Boulder City', @stateId),
    ('Carson City', @stateId),
    ('Elko', @stateId),
    ('Ely', @stateId),
    ('Fallon', @stateId),
    ('Genoa', @stateId),
    ('Goldfield', @stateId),
    ('Henderson', @stateId),
    ('Las Vegas', @stateId),
    ('North Las Vegas', @stateId),
    ('Reno', @stateId),
    ('Sparks', @stateId),
    ('Virginia City', @stateId),
    ('Winnemucca', @stateId);

SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'New Hampshire');
-- Replace @stateId with the actual StateId

-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Berlin', @stateId),
    ('Claremont', @stateId),
    ('Concord', @stateId),
    ('Derry', @stateId),
    ('Dover', @stateId),
    ('Durham', @stateId),
    ('Exeter', @stateId),
    ('Franklin', @stateId),
    ('Hanover', @stateId),
    ('Hillsborough', @stateId),
    ('Keene', @stateId),
    ('Laconia', @stateId),
    ('Lebanon', @stateId),
    ('Manchester', @stateId),
    ('Nashua', @stateId),
    ('Peterborough', @stateId),
    ('Plymouth', @stateId),
    ('Portsmouth', @stateId),
    ('Rochester', @stateId),
    ('Salem', @stateId),
    ('Somersworth', @stateId);

SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'New Jersey');

-- Replace @stateId with the actual StateId

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Asbury Park', @stateId),
    ('Atlantic City', @stateId),
    ('Bayonne', @stateId),
    ('Bloomfield', @stateId),
    ('Bordentown', @stateId),
    ('Bound Brook', @stateId),
    ('Bridgeton', @stateId),
    ('Burlington', @stateId),
    ('Caldwell', @stateId),
    ('Camden', @stateId),
    ('Cape May', @stateId),
    ('Clifton', @stateId),
    ('Cranford', @stateId),
    ('East Orange', @stateId),
    ('Edison', @stateId),
    ('Elizabeth', @stateId),
    ('Englewood', @stateId),
    ('Fort Lee', @stateId),
    ('Glassboro', @stateId),
    ('Hackensack', @stateId),
    ('Haddonfield', @stateId),
    ('Hoboken', @stateId),
    ('Irvington', @stateId),
    ('Jersey City', @stateId),
    ('Lakehurst', @stateId),
    ('Lakewood', @stateId),
    ('Long Beach', @stateId),
    ('Long Branch', @stateId),
    ('Madison', @stateId),
    ('Menlo Park', @stateId),
    ('Millburn', @stateId),
    ('Millville', @stateId),
    ('Montclair', @stateId),
    ('Morristown', @stateId),
    ('Mount Holly', @stateId),
    ('New Brunswick', @stateId),
    ('New Milford', @stateId),
    ('Newark', @stateId),
    ('Ocean City', @stateId),
    ('Orange', @stateId),
    ('Parsippany–Troy Hills', @stateId),
    ('Passaic', @stateId),
    ('Paterson', @stateId),
    ('Perth Amboy', @stateId),
    ('Plainfield', @stateId),
    ('Princeton', @stateId),
    ('Ridgewood', @stateId),
    ('Roselle', @stateId),
    ('Rutherford', @stateId),
    ('Salem', @stateId),
    ('Somerville', @stateId),
    ('South Orange Village', @stateId),
    ('Totowa', @stateId),
    ('Trenton', @stateId),
    ('Union', @stateId),
    ('Union City', @stateId),
    ('Vineland', @stateId),
    ('Wayne', @stateId),
    ('Weehawken', @stateId),
    ('West New York', @stateId),
    ('West Orange', @stateId),
    ('Willingboro', @stateId),
    ('Woodbridge', @stateId);

SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'New Mexico');
-- Replace @stateId with the actual StateId


-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Acoma', @stateId),
    ('Alamogordo', @stateId),
    ('Albuquerque', @stateId),
    ('Artesia', @stateId),
    ('Belen', @stateId),
    ('Carlsbad', @stateId),
    ('Clovis', @stateId),
    ('Deming', @stateId),
    ('Farmington', @stateId),
    ('Gallup', @stateId),
    ('Grants', @stateId),
    ('Hobbs', @stateId),
    ('Las Cruces', @stateId),
    ('Las Vegas', @stateId),
    ('Los Alamos', @stateId),
    ('Lovington', @stateId),
    ('Portales', @stateId),
    ('Raton', @stateId),
    ('Roswell', @stateId),
    ('Santa Fe', @stateId),
    ('Shiprock', @stateId),
    ('Silver City', @stateId),
    ('Socorro', @stateId),
    ('Taos', @stateId),
    ('Truth or Consequences', @stateId),
    ('Tucumcari', @stateId);

SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'New York');

-- Replace @stateId with the actual StateId

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Albany', @stateId),
    ('Amsterdam', @stateId),
    ('Auburn', @stateId),
    ('Babylon', @stateId),
    ('Batavia', @stateId),
    ('Beacon', @stateId),
    ('Bedford', @stateId),
    ('Binghamton', @stateId),
    ('Bronx', @stateId),
    ('Brooklyn', @stateId),
    ('Buffalo', @stateId),
    ('Chautauqua', @stateId),
    ('Cheektowaga', @stateId),
    ('Clinton', @stateId),
    ('Cohoes', @stateId),
    ('Coney Island', @stateId),
    ('Cooperstown', @stateId),
    ('Corning', @stateId),
    ('Cortland', @stateId),
    ('Crown Point', @stateId),
    ('Dunkirk', @stateId),
    ('East Aurora', @stateId),
    ('East Hampton', @stateId),
    ('Eastchester', @stateId),
    ('Elmira', @stateId),
    ('Flushing', @stateId),
    ('Forest Hills', @stateId),
    ('Fredonia', @stateId),
    ('Garden City', @stateId),
    ('Geneva', @stateId),
    ('Glens Falls', @stateId),
    ('Gloversville', @stateId),
    ('Great Neck', @stateId),
    ('Hammondsport', @stateId),
    ('Harlem', @stateId),
    ('Hempstead', @stateId),
    ('Herkimer', @stateId),
    ('Hudson', @stateId),
    ('Huntington', @stateId),
    ('Hyde Park', @stateId),
    ('Ilion', @stateId),
    ('Ithaca', @stateId),
    ('Jamestown', @stateId),
    ('Johnstown', @stateId),
    ('Kingston', @stateId),
    ('Lackawanna', @stateId),
    ('Lake Placid', @stateId),
    ('Levittown', @stateId),
    ('Lockport', @stateId),
    ('Mamaroneck', @stateId),
    ('Manhattan', @stateId),
    ('Massena', @stateId),
    ('Middletown', @stateId),
    ('Mineola', @stateId),
    ('Mount Vernon', @stateId),
    ('New Paltz', @stateId),
    ('New Rochelle', @stateId),
    ('New Windsor', @stateId),
    ('New York City', @stateId),
    ('Newburgh', @stateId),
    ('Niagara Falls', @stateId),
    ('North Hempstead', @stateId),
    ('Nyack', @stateId),
    ('Ogdensburg', @stateId),
    ('Olean', @stateId),
    ('Oneida', @stateId),
    ('Oneonta', @stateId),
    ('Ossining', @stateId),
    ('Oswego', @stateId),
    ('Oyster Bay', @stateId),
    ('Palmyra', @stateId),
    ('Peekskill', @stateId),
    ('Plattsburgh', @stateId),
    ('Port Washington', @stateId),
    ('Potsdam', @stateId),
    ('Poughkeepsie', @stateId),
    ('Queens', @stateId),
    ('Rensselaer', @stateId),
    ('Rochester', @stateId),
    ('Rome', @stateId),
    ('Rotterdam', @stateId),
    ('Rye', @stateId),
    ('Sag Harbor', @stateId),
    ('Saranac Lake', @stateId),
    ('Saratoga Springs', @stateId),
    ('Scarsdale', @stateId),
    ('Schenectady', @stateId),
    ('Seneca Falls', @stateId),
    ('Southampton', @stateId),
    ('Staten Island', @stateId),
    ('Stony Brook', @stateId),
    ('Stony Point', @stateId),
    ('Syracuse', @stateId),
    ('Tarrytown', @stateId),
    ('Ticonderoga', @stateId),
    ('Tonawanda', @stateId),
    ('Troy', @stateId),
    ('Utica', @stateId),
    ('Watertown', @stateId),
    ('Watervliet', @stateId),
    ('Watkins Glen', @stateId),
    ('West Seneca', @stateId),
    ('White Plains', @stateId),
    ('Woodstock', @stateId),
    ('Yonkers', @stateId);

SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'North Carolina');
-- Replace @stateId with the actual StateId

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Asheboro', @stateId),
    ('Asheville', @stateId),
    ('Bath', @stateId),
    ('Beaufort', @stateId),
    ('Boone', @stateId),
    ('Burlington', @stateId),
    ('Chapel Hill', @stateId),
    ('Charlotte', @stateId),
    ('Concord', @stateId),
    ('Durham', @stateId),
    ('Edenton', @stateId),
    ('Elizabeth City', @stateId),
    ('Fayetteville', @stateId),
    ('Gastonia', @stateId),
    ('Goldsboro', @stateId),
    ('Greensboro', @stateId),
    ('Greenville', @stateId),
    ('Halifax', @stateId),
    ('Henderson', @stateId),
    ('Hickory', @stateId),
    ('High Point', @stateId),
    ('Hillsborough', @stateId),
    ('Jacksonville', @stateId),
    ('Kinston', @stateId),
    ('Kitty Hawk', @stateId),
    ('Lumberton', @stateId),
    ('Morehead City', @stateId),
    ('Morganton', @stateId),
    ('Nags Head', @stateId),
    ('New Bern', @stateId),
    ('Pinehurst', @stateId),
    ('Raleigh', @stateId),
    ('Rocky Mount', @stateId),
    ('Salisbury', @stateId),
    ('Shelby', @stateId),
    ('Washington', @stateId),
    ('Wilmington', @stateId),
    ('Wilson', @stateId),
    ('Winston-Salem', @stateId);


SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'North Dakota');
-- Replace @stateId with the actual StateId

-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Bismarck', @stateId),
    ('Devils Lake', @stateId),
    ('Dickinson', @stateId),
    ('Fargo', @stateId),
    ('Grand Forks', @stateId),
    ('Jamestown', @stateId),
    ('Mandan', @stateId),
    ('Minot', @stateId),
    ('Rugby', @stateId),
    ('Valley City', @stateId),
    ('Wahpeton', @stateId),
    ('Williston', @stateId);

SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Ohio');
-- Replace @stateId with the actual StateId

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Akron', @stateId),
    ('Alliance', @stateId),
    ('Ashtabula', @stateId),
    ('Athens', @stateId),
    ('Barberton', @stateId),
    ('Bedford', @stateId),
    ('Bellefontaine', @stateId),
    ('Bowling Green', @stateId),
    ('Canton', @stateId),
    ('Chillicothe', @stateId),
    ('Cincinnati', @stateId),
    ('Cleveland', @stateId),
    ('Cleveland Heights', @stateId),
    ('Columbus', @stateId),
    ('Conneaut', @stateId),
    ('Cuyahoga Falls', @stateId),
    ('Dayton', @stateId),
    ('Defiance', @stateId),
    ('Delaware', @stateId),
    ('East Cleveland', @stateId),
    ('East Liverpool', @stateId),
    ('Elyria', @stateId),
    ('Euclid', @stateId),
    ('Findlay', @stateId),
    ('Gallipolis', @stateId),
    ('Greenville', @stateId),
    ('Hamilton', @stateId),
    ('Kent', @stateId),
    ('Kettering', @stateId),
    ('Lakewood', @stateId),
    ('Lancaster', @stateId),
    ('Lima', @stateId),
    ('Lorain', @stateId),
    ('Mansfield', @stateId),
    ('Marietta', @stateId),
    ('Marion', @stateId),
    ('Martins Ferry', @stateId),
    ('Massillon', @stateId),
    ('Mentor', @stateId),
    ('Middletown', @stateId),
    ('Milan', @stateId),
    ('Mount Vernon', @stateId),
    ('New Philadelphia', @stateId),
    ('Newark', @stateId),
    ('Niles', @stateId),
    ('North College Hill', @stateId),
    ('Norwalk', @stateId),
    ('Oberlin', @stateId),
    ('Painesville', @stateId),
    ('Parma', @stateId),
    ('Piqua', @stateId),
    ('Portsmouth', @stateId),
    ('Put-in-Bay', @stateId),
    ('Salem', @stateId),
    ('Sandusky', @stateId),
    ('Shaker Heights', @stateId),
    ('Springfield', @stateId),
    ('Steubenville', @stateId),
    ('Tiffin', @stateId),
    ('Toledo', @stateId),
    ('Urbana', @stateId),
    ('Warren', @stateId),
    ('Wooster', @stateId),
    ('Worthington', @stateId),
    ('Xenia', @stateId),
    ('Yellow Springs', @stateId),
    ('Youngstown', @stateId),
    ('Zanesville', @stateId);


SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Oklahoma');
-- Replace @stateId with the actual StateId

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Ada', @stateId),
    ('Altus', @stateId),
    ('Alva', @stateId),
    ('Anadarko', @stateId),
    ('Ardmore', @stateId),
    ('Bartlesville', @stateId),
    ('Bethany', @stateId),
    ('Chickasha', @stateId),
    ('Claremore', @stateId),
    ('Clinton', @stateId),
    ('Cushing', @stateId),
    ('Duncan', @stateId),
    ('Durant', @stateId),
    ('Edmond', @stateId),
    ('El Reno', @stateId),
    ('Elk City', @stateId),
    ('Enid', @stateId),
    ('Eufaula', @stateId),
    ('Frederick', @stateId),
    ('Guthrie', @stateId),
    ('Guymon', @stateId),
    ('Hobart', @stateId),
    ('Holdenville', @stateId),
    ('Hugo', @stateId),
    ('Lawton', @stateId),
    ('McAlester', @stateId),
    ('Miami', @stateId),
    ('Midwest City', @stateId),
    ('Moore', @stateId),
    ('Muskogee', @stateId),
    ('Norman', @stateId),
    ('Oklahoma City', @stateId),
    ('Okmulgee', @stateId),
    ('Pauls Valley', @stateId),
    ('Pawhuska', @stateId),
    ('Perry', @stateId),
    ('Ponca City', @stateId),
    ('Pryor', @stateId),
    ('Sallisaw', @stateId),
    ('Sand Springs', @stateId),
    ('Sapulpa', @stateId),
    ('Seminole', @stateId),
    ('Shawnee', @stateId),
    ('Stillwater', @stateId),
    ('Tahlequah', @stateId),
    ('The Village', @stateId),
    ('Tulsa', @stateId),
    ('Vinita', @stateId),
    ('Wewoka', @stateId),
    ('Woodward', @stateId);

SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Oregon');
-- Replace @stateId with the actual StateId

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Albany', @stateId),
    ('Ashland', @stateId),
    ('Astoria', @stateId),
    ('Baker City', @stateId),
    ('Beaverton', @stateId),
    ('Bend', @stateId),
    ('Brookings', @stateId),
    ('Burns', @stateId),
    ('Coos Bay', @stateId),
    ('Corvallis', @stateId),
    ('Eugene', @stateId),
    ('Grants Pass', @stateId),
    ('Hillsboro', @stateId),
    ('Hood River', @stateId),
    ('Jacksonville', @stateId),
    ('John Day', @stateId),
    ('Klamath Falls', @stateId),
    ('La Grande', @stateId),
    ('Lake Oswego', @stateId),
    ('Lakeview', @stateId),
    ('McMinnville', @stateId),
    ('Medford', @stateId),
    ('Newberg', @stateId),
    ('Newport', @stateId),
    ('Ontario', @stateId),
    ('Oregon City', @stateId),
    ('Pendleton', @stateId),
    ('Port Orford', @stateId),
    ('Portland', @stateId),
    ('Prineville', @stateId),
    ('Redmond', @stateId),
    ('Reedsport', @stateId),
    ('Roseburg', @stateId),
    ('Salem', @stateId),
    ('Seaside', @stateId),
    ('Springfield', @stateId),
    ('The Dalles', @stateId),
    ('Tillamook', @stateId);
    
SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Pennsylvania');
-- Replace @stateId with the actual StateId

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Abington', @stateId),
    ('Aliquippa', @stateId),
    ('Allentown', @stateId),
    ('Altoona', @stateId),
    ('Ambridge', @stateId),
    ('Bedford', @stateId),
    ('Bethlehem', @stateId),
    ('Bloomsburg', @stateId),
    ('Bradford', @stateId),
    ('Bristol', @stateId),
    ('Carbondale', @stateId),
    ('Carlisle', @stateId),
    ('Chambersburg', @stateId),
    ('Chester', @stateId),
    ('Columbia', @stateId),
    ('Easton', @stateId),
    ('Erie', @stateId),
    ('Franklin', @stateId),
    ('Germantown', @stateId),
    ('Gettysburg', @stateId),
    ('Greensburg', @stateId),
    ('Hanover', @stateId),
    ('Harmony', @stateId),
    ('Harrisburg', @stateId),
    ('Hazleton', @stateId),
    ('Hershey', @stateId),
    ('Homestead', @stateId),
    ('Honesdale', @stateId),
    ('Indiana', @stateId),
    ('Jeannette', @stateId),
    ('Jim Thorpe', @stateId),
    ('Johnstown', @stateId),
    ('Lancaster', @stateId),
    ('Lebanon', @stateId),
    ('Levittown', @stateId),
    ('Lewistown', @stateId),
    ('Lock Haven', @stateId),
    ('Lower Southampton', @stateId),
    ('McKeesport', @stateId),
    ('Meadville', @stateId),
    ('Middletown', @stateId),
    ('Monroeville', @stateId),
    ('Nanticoke', @stateId),
    ('New Castle', @stateId),
    ('New Hope', @stateId),
    ('New Kensington', @stateId),
    ('Norristown', @stateId),
    ('Oil City', @stateId),
    ('Philadelphia', @stateId),
    ('Phoenixville', @stateId),
    ('Pittsburgh', @stateId),
    ('Pottstown', @stateId),
    ('Pottsville', @stateId),
    ('Reading', @stateId),
    ('Scranton', @stateId),
    ('Shamokin', @stateId),
    ('Sharon', @stateId),
    ('State College', @stateId),
    ('Stroudsburg', @stateId),
    ('Sunbury', @stateId),
    ('Swarthmore', @stateId),
    ('Tamaqua', @stateId),
    ('Titusville', @stateId),
    ('Uniontown', @stateId),
    ('Warren', @stateId),
    ('Washington', @stateId),
    ('West Chester', @stateId),
    ('Wilkes-Barre', @stateId),
    ('Williamsport', @stateId),
    ('York', @stateId);


SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Rhode Island');
-- Replace @stateId with the actual StateId

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Barrington', @stateId),
    ('Bristol', @stateId),
    ('Central Falls', @stateId),
    ('Cranston', @stateId),
    ('East Greenwich', @stateId),
    ('East Providence', @stateId),
    ('Kingston', @stateId),
    ('Middletown', @stateId),
    ('Narragansett', @stateId),
    ('Newport', @stateId),
    ('North Kingstown', @stateId),
    ('Pawtucket', @stateId),
    ('Portsmouth', @stateId),
    ('Providence', @stateId),
    ('South Kingstown', @stateId),
    ('Tiverton', @stateId),
    ('Warren', @stateId),
    ('Warwick', @stateId),
    ('Westerly', @stateId),
    ('Wickford', @stateId),
    ('Woonsocket', @stateId);
    
SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'South Carolina');
-- Replace @stateId with the actual StateId

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Abbeville', @stateId),
    ('Aiken', @stateId),
    ('Anderson', @stateId),
    ('Beaufort', @stateId),
    ('Camden', @stateId),
    ('Charleston', @stateId),
    ('Columbia', @stateId),
    ('Darlington', @stateId),
    ('Florence', @stateId),
    ('Gaffney', @stateId),
    ('Georgetown', @stateId),
    ('Greenville', @stateId),
    ('Greenwood', @stateId),
    ('Hartsville', @stateId),
    ('Lancaster', @stateId),
    ('Mount Pleasant', @stateId),
    ('Myrtle Beach', @stateId),
    ('Orangeburg', @stateId),
    ('Rock Hill', @stateId),
    ('Spartanburg', @stateId),
    ('Sumter', @stateId),
    ('Union', @stateId);


SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'South Dakota');
-- Replace @stateId with the actual StateId

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Aberdeen', @stateId),
    ('Belle Fourche', @stateId),
    ('Brookings', @stateId),
    ('Canton', @stateId),
    ('Custer', @stateId),
    ('De Smet', @stateId),
    ('Deadwood', @stateId),
    ('Hot Springs', @stateId),
    ('Huron', @stateId),
    ('Lead', @stateId),
    ('Madison', @stateId),
    ('Milbank', @stateId),
    ('Mitchell', @stateId),
    ('Mobridge', @stateId),
    ('Pierre', @stateId),
    ('Rapid City', @stateId),
    ('Sioux Falls', @stateId),
    ('Spearfish', @stateId),
    ('Sturgis', @stateId),
    ('Vermillion', @stateId),
    ('Watertown', @stateId),
    ('Yankton', @stateId);

SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Tennessee');
-- Replace @stateId with the actual StateId

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Alcoa', @stateId),
    ('Athens', @stateId),
    ('Chattanooga', @stateId),
    ('Clarksville', @stateId),
    ('Cleveland', @stateId),
    ('Columbia', @stateId),
    ('Cookeville', @stateId),
    ('Dayton', @stateId),
    ('Elizabethton', @stateId),
    ('Franklin', @stateId),
    ('Gallatin', @stateId),
    ('Gatlinburg', @stateId),
    ('Greeneville', @stateId),
    ('Jackson', @stateId),
    ('Johnson City', @stateId),
    ('Jonesborough', @stateId),
    ('Kingsport', @stateId),
    ('Knoxville', @stateId),
    ('Lebanon', @stateId),
    ('Maryville', @stateId),
    ('Memphis', @stateId),
    ('Morristown', @stateId),
    ('Murfreesboro', @stateId),
    ('Nashville', @stateId),
    ('Norris', @stateId),
    ('Oak Ridge', @stateId),
    ('Shelbyville', @stateId),
    ('Tullahoma', @stateId);


SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Texas');
-- Replace @stateId with the actual StateId

-- Set the state ID

-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Abilene', @stateId),
    ('Alpine', @stateId),
    ('Amarillo', @stateId),
    ('Arlington', @stateId),
    ('Austin', @stateId),
    ('Baytown', @stateId),
    ('Beaumont', @stateId),
    ('Big Spring', @stateId),
    ('Borger', @stateId),
    ('Brownsville', @stateId),
    ('Bryan', @stateId),
    ('Canyon', @stateId),
    ('Cleburne', @stateId),
    ('College Station', @stateId),
    ('Corpus Christi', @stateId),
    ('Crystal City', @stateId),
    ('Dallas', @stateId),
    ('Del Rio', @stateId),
    ('Denison', @stateId),
    ('Denton', @stateId),
    ('Eagle Pass', @stateId),
    ('Edinburg', @stateId),
    ('El Paso', @stateId),
    ('Fort Worth', @stateId),
    ('Freeport', @stateId),
    ('Galveston', @stateId),
    ('Garland', @stateId),
    ('Goliad', @stateId),
    ('Greenville', @stateId),
    ('Harlingen', @stateId),
    ('Houston', @stateId),
    ('Huntsville', @stateId),
    ('Irving', @stateId),
    ('Johnson City', @stateId),
    ('Kilgore', @stateId),
    ('Killeen', @stateId),
    ('Kingsville', @stateId),
    ('Laredo', @stateId),
    ('Longview', @stateId),
    ('Lubbock', @stateId),
    ('Lufkin', @stateId),
    ('Marshall', @stateId),
    ('McAllen', @stateId),
    ('McKinney', @stateId),
    ('Mesquite', @stateId),
    ('Midland', @stateId),
    ('Mission', @stateId),
    ('Nacogdoches', @stateId),
    ('New Braunfels', @stateId),
    ('Odessa', @stateId),
    ('Orange', @stateId),
    ('Pampa', @stateId),
    ('Paris', @stateId),
    ('Pasadena', @stateId),
    ('Pecos', @stateId),
    ('Pharr', @stateId),
    ('Plainview', @stateId),
    ('Plano', @stateId),
    ('Port Arthur', @stateId),
    ('Port Lavaca', @stateId),
    ('Richardson', @stateId),
    ('San Angelo', @stateId),
    ('San Antonio', @stateId),
    ('San Felipe', @stateId),
    ('San Marcos', @stateId),
    ('Sherman', @stateId),
    ('Sweetwater', @stateId),
    ('Temple', @stateId),
    ('Texarkana', @stateId),
    ('Texas City', @stateId),
    ('Tyler', @stateId),
    ('Uvalde', @stateId),
    ('Victoria', @stateId),
    ('Waco', @stateId),
    ('Weatherford', @stateId),
    ('Wichita Falls', @stateId),
    ('Ysleta', @stateId);


SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Utah');
-- Replace @stateId with the actual StateId

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Alta', @stateId),
    ('American Fork', @stateId),
    ('Bountiful', @stateId),
    ('Brigham City', @stateId),
    ('Cedar City', @stateId),
    ('Clearfield', @stateId),
    ('Delta', @stateId),
    ('Fillmore', @stateId),
    ('Green River', @stateId),
    ('Heber City', @stateId),
    ('Kanab', @stateId),
    ('Layton', @stateId),
    ('Lehi', @stateId),
    ('Logan', @stateId),
    ('Manti', @stateId),
    ('Moab', @stateId),
    ('Monticello', @stateId),
    ('Murray', @stateId),
    ('Nephi', @stateId),
    ('Ogden', @stateId),
    ('Orderville', @stateId),
    ('Orem', @stateId),
    ('Panguitch', @stateId),
    ('Park City', @stateId),
    ('Payson', @stateId),
    ('Price', @stateId),
    ('Provo', @stateId),
    ('Saint George', @stateId),
    ('Salt Lake City', @stateId),
    ('Spanish Fork', @stateId),
    ('Springville', @stateId),
    ('Tooele', @stateId),
    ('Vernal', @stateId);


SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Vermont');
-- Replace @stateId with the actual StateId

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Barre', @stateId),
    ('Bellows Falls', @stateId),
    ('Bennington', @stateId),
    ('Brattleboro', @stateId),
    ('Burlington', @stateId),
    ('Essex', @stateId),
    ('Manchester', @stateId),
    ('Middlebury', @stateId),
    ('Montpelier', @stateId),
    ('Newport', @stateId),
    ('Plymouth', @stateId),
    ('Rutland', @stateId),
    ('Saint Albans', @stateId),
    ('Saint Johnsbury', @stateId),
    ('Sharon', @stateId),
    ('Winooski', @stateId);


SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Virginia');
-- Replace @stateId with the actual StateId for Virginia

-- Set the state ID

-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Abingdon', @stateId),
    ('Alexandria', @stateId),
    ('Bristol', @stateId),
    ('Charlottesville', @stateId),
    ('Chesapeake', @stateId),
    ('Danville', @stateId),
    ('Fairfax', @stateId),
    ('Falls Church', @stateId),
    ('Fredericksburg', @stateId),
    ('Hampton', @stateId),
    ('Hanover', @stateId),
    ('Hopewell', @stateId),
    ('Lexington', @stateId),
    ('Lynchburg', @stateId),
    ('Manassas', @stateId),
    ('Martinsville', @stateId),
    ('New Market', @stateId),
    ('Newport News', @stateId),
    ('Norfolk', @stateId),
    ('Petersburg', @stateId),
    ('Portsmouth', @stateId),
    ('Reston', @stateId),
    ('Richmond', @stateId),
    ('Roanoke', @stateId),
    ('Staunton', @stateId),
    ('Suffolk', @stateId),
    ('Virginia Beach', @stateId),
    ('Waynesboro', @stateId),
    ('Williamsburg', @stateId),
    ('Winchester', @stateId);


SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Washington');
-- Replace @stateId with the actual StateId for Washington

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Aberdeen', @stateId),
    ('Anacortes', @stateId),
    ('Auburn', @stateId),
    ('Bellevue', @stateId),
    ('Bellingham', @stateId),
    ('Bremerton', @stateId),
    ('Centralia', @stateId),
    ('Coulee Dam', @stateId),
    ('Coupeville', @stateId),
    ('Ellensburg', @stateId),
    ('Ephrata', @stateId),
    ('Everett', @stateId),
    ('Hoquiam', @stateId),
    ('Kelso', @stateId),
    ('Kennewick', @stateId),
    ('Longview', @stateId),
    ('Moses Lake', @stateId),
    ('Oak Harbor', @stateId),
    ('Olympia', @stateId),
    ('Pasco', @stateId),
    ('Point Roberts', @stateId),
    ('Port Angeles', @stateId),
    ('Pullman', @stateId),
    ('Puyallup', @stateId),
    ('Redmond', @stateId),
    ('Renton', @stateId),
    ('Richland', @stateId),
    ('Seattle', @stateId),
    ('Spokane', @stateId),
    ('Tacoma', @stateId),
    ('Vancouver', @stateId),
    ('Walla Walla', @stateId),
    ('Wenatchee', @stateId),
    ('Yakima', @stateId);
    
SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'West Virginia');
-- Replace @stateId with the actual StateId for West Virginia

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Bath', @stateId),
    ('Beckley', @stateId),
    ('Bluefield', @stateId),
    ('Buckhannon', @stateId),
    ('Charles Town', @stateId),
    ('Charleston', @stateId),
    ('Clarksburg', @stateId),
    ('Elkins', @stateId),
    ('Fairmont', @stateId),
    ('Grafton', @stateId),
    ('Harpers Ferry', @stateId),
    ('Hillsboro', @stateId),
    ('Hinton', @stateId),
    ('Huntington', @stateId),
    ('Keyser', @stateId),
    ('Lewisburg', @stateId),
    ('Logan', @stateId),
    ('Martinsburg', @stateId),
    ('Morgantown', @stateId),
    ('Moundsville', @stateId),
    ('New Martinsville', @stateId),
    ('Parkersburg', @stateId),
    ('Philippi', @stateId),
    ('Point Pleasant', @stateId),
    ('Princeton', @stateId),
    ('Romney', @stateId),
    ('Shepherdstown', @stateId),
    ('South Charleston', @stateId),
    ('Summersville', @stateId),
    ('Weirton', @stateId),
    ('Welch', @stateId),
    ('Wellsburg', @stateId),
    ('Weston', @stateId),
    ('Wheeling', @stateId),
    ('White Sulphur Springs', @stateId),
    ('Williamson', @stateId);


SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Wisconsin');
-- Replace @stateId with the actual StateId for Wisconsin

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Appleton', @stateId),
    ('Ashland', @stateId),
    ('Baraboo', @stateId),
    ('Belmont', @stateId),
    ('Beloit', @stateId),
    ('Eau Claire', @stateId),
    ('Fond du Lac', @stateId),
    ('Green Bay', @stateId),
    ('Hayward', @stateId),
    ('Janesville', @stateId),
    ('Kenosha', @stateId),
    ('La Crosse', @stateId),
    ('Lake Geneva', @stateId),
    ('Madison', @stateId),
    ('Manitowoc', @stateId),
    ('Marinette', @stateId),
    ('Menasha', @stateId),
    ('Milwaukee', @stateId),
    ('Neenah', @stateId),
    ('New Glarus', @stateId),
    ('Oconto', @stateId),
    ('Oshkosh', @stateId),
    ('Peshtigo', @stateId),
    ('Portage', @stateId),
    ('Prairie du Chien', @stateId),
    ('Racine', @stateId),
    ('Rhinelander', @stateId),
    ('Ripon', @stateId),
    ('Sheboygan', @stateId),
    ('Spring Green', @stateId),
    ('Stevens Point', @stateId),
    ('Sturgeon Bay', @stateId),
    ('Superior', @stateId),
    ('Waukesha', @stateId),
    ('Wausau', @stateId),
    ('Wauwatosa', @stateId),
    ('West Allis', @stateId),
    ('West Bend', @stateId),
    ('Wisconsin Dells', @stateId);


SET @stateId := (SELECT StateId FROM StateDetails WHERE StateName = 'Wyoming');
-- Replace @stateId with the actual StateId for Wyoming

-- Set the state ID
-- Insert cities with the provided state ID
INSERT INTO CityDetails (CityName, StateId)
VALUES
    ('Buffalo', @stateId),
    ('Casper', @stateId),
    ('Cheyenne', @stateId),
    ('Cody', @stateId),
    ('Douglas', @stateId),
    ('Evanston', @stateId),
    ('Gillette', @stateId),
    ('Green River', @stateId),
    ('Jackson', @stateId),
    ('Lander', @stateId),
    ('Laramie', @stateId),
    ('Newcastle', @stateId),
    ('Powell', @stateId),
    ('Rawlins', @stateId),
    ('Riverton', @stateId),
    ('Rock Springs', @stateId),
    ('Sheridan', @stateId),
    ('Ten Sleep', @stateId),
    ('Thermopolis', @stateId),
    ('Torrington', @stateId),
    ('Worland', @stateId);



INSERT  INTO `users`(`UserId`,`UserName`,`FirstName`,`LastName`,`MiddleName`,`Password`,`UserTypeId`,`MobileNumber`,`CreatedDate`) VALUES 
(1,'owner','owner','owner','fghb','password',2,'7093435125','2023-08-17 11:40:34'),
(2,'admin ','shivadhar','owner','','password',1,'7093435125','2023-08-17 11:52:35'),
(6,'shivadhar','Shivadhar Reddy','Arikontham','','shivadharpassword ',3,'4086275912','2023-08-19 00:51:35'),
(7,'dharani','Dharani','Dodda','','dharanipassword ',3,'4086298767','2023-08-19 13:03:04'),
(8,'pallavi','Sri','Pallavi','','pallavipassword ',3,'7866578654','2023-08-19 13:05:12');





INSERT  INTO `propertydetails`(`PropertyId`,`PropertyName`,`Description`,`StateId`,`CityId`,`Price`,`PropertyTypeId`,`Amenities`,`AvailabilityDate`,`OwnerId`,`FullAddress`,`Latitude`,`Longitude`,`IsApprovedByAdmin`,`CreatedDate`) VALUES 
(1,'65 Bay Street','Signs reading \"The Heart of Jersey City: McGinley Square\" line the streets of this bustling neighborhood. The up-and-coming area of Jersey City houses small businesses, diverse eateries, and large franchises alike. The streets buzz with commuters on their way to work, students heading to class, and locals running daily errands.',1,2,1000.00,1,'Package Service,Controlled Access,Clubhouse,Playground,Gameroom','2023-08-19',1,'20 Beacon Way, Jersey City, NJ 07304','0','0',1,'2023-08-17 11:53:48'),
(3,'28 Cottage St','Impeccably crafted, CMPND sets a new standard for inspired living in downtown Jersey City.',1,2,1000.00,1,'Community-Wide WiFi, EV Charging, Multi Use Room, Key Fob Entry, Fitness Center','2023-08-12',1,'28 Cottage St, Jersey City, NJ 07306','0','0',1,'2023-08-18 09:04:10'),
(4,'9 HomeStead','Enjoy Jersey City living at 9 Homestead. You\'ll find this community in the Journal Square area of Jersey City. The leasing staff is ready to help you find your ideal place. Come see 9 Homestead today.',1,2,1000.00,1,'Concierge ,Community-Wide WiFi, 24 Hour Availability, Laundry Service','2023-08-24',1,'9 Homestead Pl, Jersey City, NJ 07306','0','0',0,'2023-08-19 05:18:01'),
(5,'Envy by Gomes','At Envy you can feel the difference. Rich finishes, exclusive amenities, and sumptuous comfort give you a life of leisure in the lap of luxury. Our bespoke accommodations and embellished common areas are all designed for the pleasure of indulgent living. This is your elevated life. High above any standard, every aspect of dwelling here has been designed for a life worthy of envy.',1,2,1000.00,1,'Maintenance on site, Elevator, Gated, Disposal Chutes, Lounge, Disposal Chutes','2023-08-25',1,'58-84 Norfolk St, Newark, NJ 07103','0','0',0,'2023-08-19 05:29:08');


INSERT  INTO `propertyimages`(`PropertyImageId`,`ImagePath`,`PropertyId`,`CreatedDate`) VALUES 
(1,'1692287626170-879084760.jpg',1,'2023-08-17 11:53:48'),
(3,'1692363848694-904726443.jpg',3,'2023-08-18 09:04:10'),
(4,'1692436681091-570952969.jpg',4,'2023-08-19 05:18:01'),
(5,'1692437348312-56402749.jpg',5,'2023-08-19 05:29:08');


INSERT  INTO `bookappointment`(`BookAppointmentId`,`CustomerId`,`PropertyId`,`CreatedDate`) VALUES 
(1,2,1,'2023-08-17 11:55:06'),
(2,2,3,'2023-08-18 09:08:29'),
(3,6,1,'2023-08-19 03:01:17'),
(4,6,3,'2023-08-19 03:53:34');





/*Data for the table `propertyrating` */

INSERT  INTO `propertyrating`(`PropertyRatingId`,`Rating`,`Review`,`PropertyId`,`CustomerId`,`CreatedDate`) VALUES 
(1,4.0,'shijhb jkd',1,2,'2023-08-17 11:55:27');

/*Data for the table `savedproperty` */

INSERT  INTO `savedproperty`(`SavedPropertyId`,`PropertyId`,`CustomerId`,`CreatedDate`) VALUES 
(1,1,2,'2023-08-17 11:56:01'),
(2,1,6,'2023-08-19 01:20:14'),
(3,3,6,'2023-08-19 01:20:57');



----------------------------------------------------------


-- STORED PROCEDURES


DELIMITER $$

USE `shivadhardharanipallavidatabase`$$

DROP PROCEDURE IF EXISTS `AddPropertyRating`$$

CREATE DEFINER=`shivadharDharaniPallavi`@`localhost` PROCEDURE `AddPropertyRating`(
    IN p_Rating DECIMAL(9,1),
    IN p_Review VARCHAR(500),
    IN p_PropertyId INT,
    IN p_CustomerId INT
)
BEGIN
    -- Check if a rating already exists for the same property and customer
    IF EXISTS (
        SELECT 1
        FROM PropertyRating
        WHERE PropertyId = p_PropertyId AND CustomerId = p_CustomerId
    ) THEN
        SELECT 'You have already added rating and reviews for thing property.' AS Result;
    ELSE
        INSERT INTO PropertyRating (Rating, Review, PropertyId, CustomerId)
        VALUES (p_Rating, p_Review, p_PropertyId, p_CustomerId);
        
         SELECT 'Success' AS Result;
    END IF;
END$$

DELIMITER ;


DELIMITER $$

USE `shivadhardharanipallavidatabase`$$

DROP PROCEDURE IF EXISTS `AuthenticateUser`$$

CREATE DEFINER=`shivadharDharaniPallavi`@`localhost` PROCEDURE `AuthenticateUser`(IN p_Username VARCHAR(50), IN p_Password VARCHAR(500))
BEGIN
    DECLARE v_UserExists INT;

    -- Check if the user exists and the password matches
    SELECT COUNT(*) INTO v_UserExists
    FROM Users
    WHERE UserName = p_Username AND PASSWORD = p_Password;

    IF v_UserExists = 1 THEN
        SELECT UserId, CONCAT(FirstName, ' ', LastName) AS NAME,
        t.UserTypeName AS UserType
        FROM Users u
        JOIN UserType t ON u.UserTypeId  = t.UserTypeId 
        WHERE UserName = p_Username AND PASSWORD = p_Password;
    ELSE
        SELECT NULL AS UserId, NULL AS NAME, NULL AS UserType;
    END IF;
END$$

DELIMITER ;


DELIMITER $$

USE `shivadhardharanipallavidatabase`$$

DROP PROCEDURE IF EXISTS `DeleteSavedProperty`$$

CREATE DEFINER=`shivadharDharaniPallavi`@`localhost` PROCEDURE `DeleteSavedProperty`(
    IN p_PropertyId INT
)
BEGIN
    DELETE FROM SavedProperty
    WHERE PropertyId = p_PropertyId;
    
	DELETE FROM PropertyRating
    WHERE PropertyId = p_PropertyId;
    
    DELETE FROM PropertyImages
    WHERE PropertyId = p_PropertyId;
    
	DELETE FROM BookAppointment
    WHERE PropertyId = p_PropertyId;
    
    DELETE FROM PropertyDetails 
    WHERE PropertyId = p_PropertyId;    
    
	SELECT 'Success' AS Result;
END$$

DELIMITER ;


DELIMITER $$

USE `shivadhardharanipallavidatabase`$$

DROP PROCEDURE IF EXISTS `GetAppointmentsByCustomerId`$$

CREATE DEFINER=`shivadharDharaniPallavi`@`localhost` PROCEDURE `GetAppointmentsByCustomerId`(IN p_CustomerId INT)
BEGIN
    SELECT
        ba.BookAppointmentId,        
        pd.PropertyName,
        pd.price,
        pd.FullAddress,
        pd.Amenities
    FROM BookAppointment ba
    JOIN PropertyDetails pd ON ba.PropertyId = pd.PropertyId
    WHERE ba.CustomerId = p_CustomerId;
END$$

DELIMITER ;

DELIMITER $$

USE `shivadhardharanipallavidatabase`$$

DROP PROCEDURE IF EXISTS `GetAppointmentsByOwnerId`$$

CREATE DEFINER=`shivadharDharaniPallavi`@`localhost` PROCEDURE `GetAppointmentsByOwnerId`(IN p_OwnerId INT)
BEGIN
    SELECT
        ba.BookAppointmentId,
        u.FirstName,
        u.LastName,
        u.MiddleName,
        u.MobileNumber,
        pd.PropertyName
    FROM BookAppointment ba
    JOIN Users u ON ba.CustomerId = u.UserId
    JOIN PropertyDetails pd ON ba.PropertyId = pd.PropertyId
    WHERE pd.OwnerId  = p_OwnerId;
END$$

DELIMITER ;


DELIMITER $$

USE `shivadhardharanipallavidatabase`$$

DROP PROCEDURE IF EXISTS `GetCitiesByStateId`$$

CREATE DEFINER=`shivadharDharaniPallavi`@`localhost` PROCEDURE `GetCitiesByStateId`(IN p_stateId INT)
BEGIN
    SELECT CityId, CityName, StateId
    FROM CityDetails
    WHERE StateId = p_stateId;
END$$

DELIMITER ;


DELIMITER $$

USE `shivadhardharanipallavidatabase`$$

DROP PROCEDURE IF EXISTS `GetFilteredProperties`$$

CREATE DEFINER=`shivadharDharaniPallavi`@`localhost` PROCEDURE `GetFilteredProperties`(IN p_stateId INT, IN p_cityId INT, IN p_price DECIMAL(9, 2), IN p_propertyTypeId INT, IN p_propertyId INT,IN p_OwnerId INT)
BEGIN
    SELECT 
        pd.PropertyId, 
        pd.PropertyName, 
        pd.Description, 
        pd.StateId, 
        pd.CityId, 
        ct.CityName, 
        pt.PropertyTypeId, 
        pt.PropertyTypeName, 
        pd.Price, 
        pd.Amenities, 
        pd.AvailabilityDate, 
        pd.OwnerId, 
        pd.FullAddress, 
        pd.Latitude, 
        pd.Longitude, 
        pd.IsApprovedByAdmin,
        GROUP_CONCAT(pi.ImagePath SEPARATOR ';') AS ImagePaths
    FROM PropertyDetails pd
    JOIN CityDetails ct ON ct.CityId = pd.CityId
    JOIN PropertyType pt ON pt.PropertyTypeId = pd.PropertyTypeId
    LEFT JOIN PropertyImages PI ON pi.PropertyId = pd.PropertyId
    WHERE (pd.IsApprovedByAdmin = 1 OR (p_OwnerId IS NOT NULL AND  p_OwnerId>0))
        AND (p_OwnerId  IS NULL OR pd.OwnerId  = p_OwnerId)
        AND (p_propertyId IS NULL OR pd.PropertyId = p_propertyId)
        AND (p_stateId IS NULL OR pd.StateId = p_stateId)
        AND (p_cityId IS NULL OR pd.CityId = p_cityId)
        AND (p_price IS NULL OR pd.Price <= p_price)
        AND (p_propertyTypeId IS NULL OR pd.PropertyTypeId = p_propertyTypeId)
    GROUP BY pd.PropertyId;
END$$

DELIMITER ;


DELIMITER $$

USE `shivadhardharanipallavidatabase`$$

DROP PROCEDURE IF EXISTS `GetPropertiesByOwner`$$

CREATE DEFINER=`shivadharDharaniPallavi`@`localhost` PROCEDURE `GetPropertiesByOwner`(IN p_OwnerId INT)
BEGIN
    SELECT
        pd.PropertyId ,        
        pd.PropertyName,
        pd.Description,
        pd.price,
        pd.FullAddress,
        pd.Amenities,
        StateId,
        CityId,
        PropertyTypeId,
        AvailabilityDate,
        Latitude,
        Longitude
    FROM PropertyDetails pd
    WHERE pd.OwnerId  = p_OwnerId;
END$$

DELIMITER ;


DELIMITER $$

USE `shivadhardharanipallavidatabase`$$

DROP PROCEDURE IF EXISTS `GetPropertiesToApprove`$$

CREATE DEFINER=`shivadharDharaniPallavi`@`localhost` PROCEDURE `GetPropertiesToApprove`()
BEGIN
    SELECT 
        pd.PropertyId, 
        pd.PropertyName, 
        pd.Description,          
        ct.CityName, 
        pt.PropertyTypeName, 
        pd.Price, 
        pd.Amenities, 
        pd.AvailabilityDate, 
        pd.OwnerId, 
        pd.FullAddress,
        u.FirstName,
        u.LastName ,
        u.MobileNumber,
		pt.PropertyTypeId, 
        pd.StateId, 
        pd.CityId
    FROM PropertyDetails pd
    JOIN CityDetails ct ON ct.CityId = pd.CityId
    JOIN PropertyType pt ON pt.PropertyTypeId = pd.PropertyTypeId
	JOIN Users  u ON u.UserId  = pd.OwnerId
    WHERE (pd.IsApprovedByAdmin = 0)
    GROUP BY pd.PropertyId;
END$$

DELIMITER ;



DELIMITER $$

USE `shivadhardharanipallavidatabase`$$

DROP PROCEDURE IF EXISTS `GetPropertyRatings`$$

CREATE DEFINER=`shivadharDharaniPallavi`@`localhost` PROCEDURE `GetPropertyRatings`(
    IN p_PropertyId INT
)
BEGIN
    SELECT PropertyRatingId, Rating, Review, PropertyId, CustomerId, CreatedDate
    FROM PropertyRating
    WHERE PropertyId = p_PropertyId
    ORDER BY PropertyRatingId DESC;
END$$

DELIMITER ;


DELIMITER $$

USE `shivadhardharanipallavidatabase`$$

DROP PROCEDURE IF EXISTS `GetPropertyTypes`$$

CREATE DEFINER=`shivadharDharaniPallavi`@`localhost` PROCEDURE `GetPropertyTypes`()
BEGIN
    SELECT PropertyTypeId, PropertyTypeName
    FROM PropertyType;
END$$

DELIMITER ;


DELIMITER $$

USE `shivadhardharanipallavidatabase`$$

DROP PROCEDURE IF EXISTS `GetSavedProperties`$$

CREATE DEFINER=`shivadharDharaniPallavi`@`localhost` PROCEDURE `GetSavedProperties`(IN p_CustomerId INT)
BEGIN
    SELECT 
        pd.PropertyId, 
        pd.PropertyName, 
        pd.Description, 
        pd.StateId, 
        pd.CityId, 
        ct.CityName, 
        pt.PropertyTypeId, 
        pt.PropertyTypeName, 
        pd.Price, 
        pd.Amenities, 
        pd.AvailabilityDate, 
        pd.OwnerId, 
        pd.FullAddress, 
        pd.Latitude, 
        pd.Longitude, 
        pd.IsApprovedByAdmin,
        GROUP_CONCAT(pi.ImagePath SEPARATOR ';') AS ImagePaths
    FROM PropertyDetails pd
    JOIN CityDetails ct ON ct.CityId = pd.CityId
    JOIN PropertyType pt ON pt.PropertyTypeId = pd.PropertyTypeId
    INNER JOIN SavedProperty sp ON pd.PropertyId = sp.PropertyId
    LEFT JOIN PropertyImages PI ON pi.PropertyId = pd.PropertyId
    WHERE (pd.IsApprovedByAdmin = 1)
         AND sp.CustomerId  =p_CustomerId       
    GROUP BY pd.PropertyId;
END$$

DELIMITER ;


DELIMITER $$

USE `shivadhardharanipallavidatabase`$$

DROP PROCEDURE IF EXISTS `GetStateDetails`$$

CREATE DEFINER=`shivadharDharaniPallavi`@`localhost` PROCEDURE `GetStateDetails`()
BEGIN
    SELECT stateId, stateName
    FROM StateDetails;
END$$

DELIMITER ;


DELIMITER $$

USE `shivadhardharanipallavidatabase`$$

DROP PROCEDURE IF EXISTS `GetUserTypes`$$

CREATE DEFINER=`shivadharDharaniPallavi`@`localhost` PROCEDURE `GetUserTypes`(
    IN isAdmin BOOL
)
BEGIN
    IF isAdmin THEN
        SELECT UserTypeId,UserTypeName FROM UserType;
    ELSE
        SELECT  UserTypeId,UserTypeName FROM UserType WHERE UserTypeName != 'Admin';
    END IF;
END$$

DELIMITER ;


DELIMITER $$

USE `shivadhardharanipallavidatabase`$$

DROP PROCEDURE IF EXISTS `InsertBookAppointment`$$

CREATE DEFINER=`shivadharDharaniPallavi`@`localhost` PROCEDURE `InsertBookAppointment`(
    IN p_PropertyId INT,
    IN p_CustomerId INT
)
BEGIN
    DECLARE propertyCount INT;
    
    -- Check if the appointment already exists for the same property and customer
    SELECT COUNT(*) INTO propertyCount
    FROM BookAppointment
    WHERE PropertyId = p_PropertyId AND CustomerId = p_CustomerId;
    
    IF propertyCount = 0 THEN
        -- Insert the appointment
        INSERT INTO BookAppointment (PropertyId, CustomerId) VALUES (p_PropertyId, p_CustomerId);
        SELECT 'Success' AS Result;
    ELSE
        SELECT 'Appointment already exists for the same property and customer' AS Result;
    END IF;
END$$

DELIMITER ;



DELIMITER $$

USE `shivadhardharanipallavidatabase`$$

DROP PROCEDURE IF EXISTS `InsertImages`$$

CREATE DEFINER=`shivadharDharaniPallavi`@`localhost` PROCEDURE `InsertImages`(IN imageNames TEXT, IN propertyId INT)
BEGIN
    DECLARE imageName TEXT;
    DECLARE imageCount INT;
    DECLARE currentIndex INT DEFAULT 1;

    SET imageCount = LENGTH(imageNames) - LENGTH(REPLACE(imageNames, ';', '')) + 1;

    WHILE currentIndex <= imageCount DO
        SET imageName = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(imageNames, ';', currentIndex), ';', -1));

        INSERT INTO PropertyImages (ImagePath, PropertyId) VALUES (imageName, propertyId);

        SET currentIndex = currentIndex + 1;
    END WHILE;
END$$

DELIMITER ;



DELIMITER $$

USE `shivadhardharanipallavidatabase`$$

DROP PROCEDURE IF EXISTS `InsertSavedProperty`$$

CREATE DEFINER=`shivadharDharaniPallavi`@`localhost` PROCEDURE `InsertSavedProperty`(
    IN p_PropertyId INT,
    IN p_CustomerId INT
)
BEGIN
    DECLARE existingCount INT;
    
    -- Check if the record already exists
    SELECT COUNT(*) INTO existingCount
    FROM SavedProperty
    WHERE PropertyId = p_PropertyId AND CustomerId = p_CustomerId;
    
    IF existingCount > 0 THEN       
        SELECT 'You have already saved this property.' AS Result;
    ELSE
        -- Insert the data if it doesn't exist
        INSERT INTO SavedProperty (PropertyId, CustomerId)
        VALUES (p_PropertyId, p_CustomerId);
        
        SELECT 'Success' AS Result;
    END IF;
END$$

DELIMITER ;


DELIMITER $$

USE `shivadhardharanipallavidatabase`$$

DROP PROCEDURE IF EXISTS `SaveUsers`$$

CREATE DEFINER=`shivadharDharaniPallavi`@`localhost` PROCEDURE `SaveUsers`(
IN p_UserName VARCHAR(50),
IN FirstName VARCHAR(50),
IN LastName VARCHAR(50),
IN MiddleName VARCHAR(50),
IN p_Password VARCHAR(500),
IN UserTypeId INT,
IN MobileNumber VARCHAR(20)
)
BEGIN
    DECLARE userCount INT;
    
    -- Check if a user with the same username and password exists
    SELECT COUNT(*) INTO userCount
    FROM users
    WHERE UserName = p_UserName AND PASSWORD = p_Password;
    
    -- If no such user exists, insert the new user
    IF userCount = 0 THEN
        INSERT INTO users (UserName, FirstName, LastName, MiddleName, PASSWORD, UserTypeId, MobileNumber)
        VALUES (p_UserName, FirstName, LastName, MiddleName, p_Password, UserTypeId, MobileNumber);
        
    SELECT 'Success' AS Result;
    ELSE
      SELECT 'User with the same username already exists.' AS Result;
    END IF;
END$$

DELIMITER ;


DELIMITER $$

USE `shivadhardharanipallavidatabase`$$

DROP PROCEDURE IF EXISTS `UpdatePropertyApproval`$$

CREATE DEFINER=`shivadharDharaniPallavi`@`localhost` PROCEDURE `UpdatePropertyApproval`(IN p_PropertyId INT)
BEGIN
    UPDATE PropertyDetails
    SET IsApprovedByAdmin = 1
    WHERE PropertyId = p_PropertyId;    
END$$

DELIMITER ;





DELIMITER //

CREATE PROCEDURE InsertOrUpdatePropertyDetails(
    IN p_PropertyId INT,
    IN p_PropertyName VARCHAR(50),
    IN p_Description VARCHAR(500),
    IN p_StateId INT,
    IN p_CityId INT,
    IN p_Price DECIMAL(9,2),
    IN p_PropertyTypeId INT,
    IN p_Amenities VARCHAR(1000),
    IN p_AvailabilityDate DATE,
    IN p_OwnerId INT,
    IN p_FullAddress VARCHAR(500),
    IN p_Latitude VARCHAR(30),
    IN p_Longitude VARCHAR(30),
    IN p_IsApprovedByAdmin BOOL,
    IN p_ImageNames TEXT 
)
BEGIN
    IF p_PropertyId > 0 THEN
        -- Update existing property
        UPDATE PropertyDetails
        SET
            PropertyName = p_PropertyName,
            DESCRIPTION = p_Description,
            StateId = p_StateId,
            CityId = p_CityId,
            Price = p_Price,
            PropertyTypeId = p_PropertyTypeId,
            Amenities = p_Amenities,
            AvailabilityDate = p_AvailabilityDate,
            OwnerId = p_OwnerId,
            FullAddress = p_FullAddress,
            Latitude = p_Latitude,
            Longitude = p_Longitude
        WHERE PropertyId = p_PropertyId;
    ELSE
        -- Insert new property
        INSERT INTO PropertyDetails (
            PropertyName, DESCRIPTION, StateId, CityId, Price, PropertyTypeId,
            Amenities, AvailabilityDate, OwnerId, FullAddress, Latitude, Longitude, IsApprovedByAdmin
        )
        VALUES (
            p_PropertyName, p_Description, p_StateId, p_CityId, p_Price, p_PropertyTypeId,
            p_Amenities, p_AvailabilityDate, p_OwnerId, p_FullAddress, p_Latitude, p_Longitude, p_IsApprovedByAdmin
        );
	   SET p_PropertyId = LAST_INSERT_ID();

    END IF;
    
  IF p_PropertyId > 0 THEN
    BEGIN
        CALL InsertImages(p_imageNames, p_PropertyId);
    END;
END IF;
    
END;
//

DELIMITER ;
