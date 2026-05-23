-- ========================================
-- 1. Organization Table Schema
-- ========================================
CREATE TABLE IF NOT EXISTS organization (
    organization_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    logo_filename VARCHAR(255) NOT NULL
);

-- ========================================
-- 2. Insert Sample Data: Organizations
-- ========================================
INSERT INTO organization (name, description, contact_email, logo_filename)
VALUES
('BrightFuture Builders', 'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 'info@brightfuturebuilders.org', 'brightfuture-logo.png'),
('GreenHarvest Growers', 'An urban farming collective promoting food sustainability and education in local neighborhoods.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
('UnityServe Volunteers', 'A volunteer coordination group supporting local charities and service initiatives.', 'hello@unityserve.org', 'unityserve-logo.png');

-- ========================================
-- 3. Project Table Schema
-- ========================================
CREATE TABLE IF NOT EXISTS project (
    project_id SERIAL PRIMARY KEY,
    organization_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    CONSTRAINT fk_organization 
        FOREIGN KEY(organization_id) 
        REFERENCES organization(organization_id) 
        ON DELETE CASCADE
);

-- ========================================
-- 4. Insert Sample Data: 15 Service Projects
-- ========================================
INSERT INTO project (organization_id, title, description, location, date)
VALUES
(1, 'Community Center Renovation', 'Repairing the roof and painting the main community hall.', 'Downtown Community Center', '2026-06-12'),
(1, 'Park Bench Assembly', 'Building and installing 10 new sustainable wood benches.', 'Central Park', '2026-06-20'),
(1, 'Sidewalk Repair Drive', 'Fixing cracked walkways near the local elementary school.', 'Northside District', '2026-07-05'),
(1, 'Tiny Homes Construction', 'Assisting in building temporary shelter units for families.', 'Hope Village Camp', '2026-07-19'),
(1, 'Library Ramp Upgrade', 'Pouring concrete to construct a new wheelchair accessible ramp.', 'Public Library East', '2026-08-01'),
(2, 'Spring Seed Planting', 'Sowing seeds for tomatoes, lettuce, and carrots for the season.', 'Community Greenhouse', '2026-06-05'),
(2, 'Urban Soil Enrichment', 'Mixing compost and treating raised beds for local plots.', 'Downtown Garden Plot B', '2026-06-18'),
(2, 'Rain Barrel Installation', 'Setting up water conservation barrels around the neighborhood.', 'South Neighborhood Orchard', '2026-07-02'),
(2, 'Harvest Festival Prep', 'Gathering ripe vegetables and organizing market booths.', 'City Farmers Market', '2026-07-25'),
(2, 'Composting Workshop Support', 'Helping teach community members how to recycle organic waste.', 'GreenHarvest Center', '2026-08-10'),
(3, 'Senior Center Meal Delivery', 'Packaging and delivering healthy hot lunches to homebound elders.', 'Senior Care Center', '2026-06-10'),
(3, 'School Supply Drive Sorting', 'Organizing backpacks and stationery donations for students.', 'Unity Warehouse', '2026-06-25'),
(3, 'Food Pantry Sorting Night', 'Checking expiration dates and organizing canned goods shelves.', 'City Food Bank', '2026-07-11'),
(3, 'Shelter Blanket Distribution', 'Handing out clothing and blankets to those in temporary housing.', 'Grace Shelter', '2026-07-30'),
(3, 'Youth Mentorship Kickoff', 'Setting up games and matching tutors with local children.', 'Boys and Girls Club', '2026-08-15');

-- ========================================
-- 5. Category Table Schema
-- ========================================
CREATE TABLE IF NOT EXISTS category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- ========================================
-- 6. Project-Category Join Table Schema (Many-to-Many)
-- ========================================
CREATE TABLE IF NOT EXISTS project_category (
    project_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (project_id, category_id),
    CONSTRAINT fk_project 
        FOREIGN KEY (project_id) 
        REFERENCES project(project_id) 
        ON DELETE CASCADE,
    CONSTRAINT fk_category 
        FOREIGN KEY (category_id) 
        REFERENCES category(category_id) 
        ON DELETE CASCADE
);

-- ========================================
-- 7. Insert Sample Data: Categories
-- ========================================
INSERT INTO category (name)
VALUES
('Environmental'),
('Educational'),
('Community Service'),
('Health and Wellness');

-- ========================================
-- 8. Link Existing 15 Projects to Categories
-- ========================================
INSERT INTO project_category (project_id, category_id)
VALUES
-- Projects 1-5 (BrightFuture Builders) -> Community Service (3) & Environmental (1)
(1, 3), (2, 3), (2, 1), (3, 3), (4, 3), (5, 3),
-- Projects 6-10 (GreenHarvest Growers) -> Environmental (1) & Health and Wellness (4)
(6, 1), (6, 4), (7, 1), (8, 1), (9, 3), (9, 4), (10, 2), (10, 1),
-- Projects 11-15 (UnityServe Volunteers) -> Community Service (3) & Educational (2)
(11, 4), (11, 3), (12, 2), (12, 3), (13, 3), (14, 3), (15, 2);
