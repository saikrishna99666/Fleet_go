CREATE TABLE admin_settings (
    aid INT AUTO_INCREMENT PRIMARY KEY,
    aname VARCHAR(100),
    aemail VARCHAR(150) UNIQUE,
    apassword VARCHAR(255),
    smtp_host VARCHAR(150),
    smtp_port INT,
    smtp_user VARCHAR(150),
    smtp_password VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;


CREATE TABLE employees (
    eid INT AUTO_INCREMENT PRIMARY KEY,
    ename VARCHAR(100),
    eemail VARCHAR(150) UNIQUE,
    epassword VARCHAR(255),
    e_description TEXT,
    e_screenshot TEXT,
    status TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;


CREATE TABLE logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    log_description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;







CREATE TABLE companies (
    cid INT AUTO_INCREMENT PRIMARY KEY,
    cname VARCHAR(150) NOT NULL,
    cphone VARCHAR(20),
    cemail VARCHAR(150) UNIQUE NOT NULL,
    cpassword VARCHAR(255) NOT NULL,
    address TEXT,
    curl VARCHAR(255) UNIQUE,
    zipcode VARCHAR(10),
    exp_date DATE,
    status TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;


CREATE TABLE transactions (
    tid INT AUTO_INCREMENT PRIMARY KEY,
    cid INT,
    renewal_date DATE,
    exp_date DATE,
    trans_id VARCHAR(100),
    trans_details TEXT,
    trans_screenshot TEXT,
    status TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_trans_company FOREIGN KEY (cid) REFERENCES companies(cid)
) ENGINE=InnoDB;


-- COMPANY

CREATE TABLE company_settings (
    cid INT PRIMARY KEY,
    cname VARCHAR(150),
    cphone VARCHAR(20),
    cemail VARCHAR(150),
    cpassword VARCHAR(255),
    address TEXT,
    curl VARCHAR(255),
    zipcode VARCHAR(10),
    exp_date DATE,
    status TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE company_users (
    uid INT AUTO_INCREMENT PRIMARY KEY,
    cid int,
    uemail VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    status TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE mst_status (
    sid INT AUTO_INCREMENT PRIMARY KEY,
    s_name VARCHAR(50) UNIQUE
) ENGINE=InnoDB;

CREATE TABLE vendors (
    vendor_id INT AUTO_INCREMENT PRIMARY KEY,
    vname VARCHAR(100),
    vemail VARCHAR(150),
    vphone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE vendor_types (
    vt_id INT AUTO_INCREMENT PRIMARY KEY,
    vtype_name VARCHAR(100)
) ENGINE=InnoDB;



CREATE TABLE vehicles (
    vid INT AUTO_INCREMENT PRIMARY KEY,
    v_no VARCHAR(50) UNIQUE,
    kms_driven INT,
    status TINYINT(1) DEFAULT 1,
    vendor_id INT,
    v_image TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_vehicle_vendor FOREIGN KEY (vendor_id) REFERENCES vendors(vendor_id)
) ENGINE=InnoDB;


CREATE TABLE vehicle_details (
    vid INT PRIMARY KEY,
    type VARCHAR(50),
    year INT,
    make VARCHAR(50),
    model VARCHAR(50),
    vin_sn VARCHAR(50),
    license_plate VARCHAR(50),
    driver_id INT,
    color VARCHAR(30),
    body_type VARCHAR(50),
    body_subtype VARCHAR(50),
    msrp DECIMAL(12,2),
    registration_state VARCHAR(50),
    ownership VARCHAR(50),                 -- Leased
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
               ON UPDATE CURRENT_TIMESTAMP
    CONSTRAINT fk_vd_vehicle FOREIGN KEY (vid) REFERENCES vehicles(vid)
) ENGINE=InnoDB;


CREATE TABLE vehicle_specs (
    vid INT PRIMARY KEY,
    engine VARCHAR(100),
    transmission VARCHAR(100),
    fuel_type VARCHAR(50),
    CONSTRAINT fk_vs_vehicle FOREIGN KEY (vid) REFERENCES vehicles(vid)
) ENGINE=InnoDB;

CREATE TABLE vehicle_assignment (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    status VARCHAR(50),                    -- VOR Breakdown/Defect
    vehicle_group VARCHAR(100),            -- JCo Logistics
    driver_operator VARCHAR(100),          -- Craig Forsyth
    odometer_km INT,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

CREATE TABLE vehicle_body_details (
    body_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    color VARCHAR(30),                     -- White
    body_type VARCHAR(50),                 -- Pantec - TRS
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

CREATE TABLE vehicle_dimensions (
    dimension_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    length_cm DECIMAL(6,2),
    width_cm DECIMAL(6,2),
    height_cm DECIMAL(6,2),
    ground_clearance_cm DECIMAL(6,2),
    cargo_volume DECIMAL(8,2),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

CREATE TABLE vehicle_weight (
    weight_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    curb_weight_kg INT,
    gvwr_kg INT,
    max_payload_kg INT,
    towing_capacity_kg INT,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

CREATE TABLE vehicle_engine (
    engine_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    fuel_type VARCHAR(20),                 -- EV
    engine_brand VARCHAR(50),
    cylinders INT,
    displacement_cc INT,
    max_hp INT,
    max_torque_nm INT,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

CREATE TABLE vehicle_fluids (
    fluid_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    fuel_type VARCHAR(20),                 -- EV
    fuel_tank_1_capacity DECIMAL(6,2),
    fuel_tank_2_capacity DECIMAL(6,2),
    oil_capacity DECIMAL(6,2),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);


CREATE TABLE drivers (
    did INT AUTO_INCREMENT PRIMARY KEY,
    driver_user_name VARCHAR(100) UNIQUE,
    d_first_name VARCHAR(100),
    d_last_name VARCHAR(100),
    d_password VARCHAR(255),
    d_emailid VARCHAR(150),
    d_phone VARCHAR(20),
    status TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;