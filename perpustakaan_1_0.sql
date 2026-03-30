CREATE DATABASE perpustakaan_1_0;
USE perpustakaan_1_0;
CREATE TABLE roles (
	id_roles CHAR(36) PRIMARY KEY DEFAULT (UUID()),
	role_name VARCHAR(50) NOT NULL UNIQUE,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE users_account (
	id_users_account CHAR(36) PRIMARY KEY DEFAULT (UUID()),
	roles_id CHAR(36) NOT NULL,
	name_u VARCHAR(100) NOT NULL,
	email VARCHAR(150) NOT NULL UNIQUE,
	password_u VARCHAR(255) NOT NULL,
	phone VARCHAR(20),
	address_u TEXT,
	profile_photo VARCHAR(255),
	status_u ENUM('active', 'inactive', 'suspended') DEFAULT 'active',
	email_verified_at DATETIME NULL,
	last_login DATETIME NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	
	CONSTRAINT fk_users_roles
	FOREIGN KEY (roles_id) REFERENCES roles(id_roles)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);
CREATE TABLE users_details (
	id_users_details CHAR(36) PRIMARY KEY DEFAULT (UUID()),
	account_users_id CHAR(36) NOT NULL UNIQUE,
	users_details_code VARCHAR(30) NOT NULL UNIQUE,
	users_details_type ENUM('mahasiswa', 'pelajar', 'dosen', 'pengusaha', 'karyawan', 'lainnya') NOT NULL,
	institution VARCHAR(150) NULL,
	date_of_birth DATE NULL,
	gender ENUM('L', 'P') NULL,
	registration_date DATE NOT NULL DEFAULT (CURRENT_DATE),
	expiry_date_u DATE NULL,
	status_u ENUM('active', 'inactive', 'blocked') DEFAULT 'active',
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

	CONSTRAINT fk_users_details_users_account
	FOREIGN KEY (account_users_id) REFERENCES users_account(id_users_account)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);
CREATE TABLE categories (
	id_categories CHAR(36) PRIMARY KEY DEFAULT (UUID()),
	category_name VARCHAR(100) NOT NULL UNIQUE,
	description_c TEXT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE books (
	id_books CHAR(36) PRIMARY KEY DEFAULT (UUID()),
	categories_id CHAR(36) NOT NULL,
	isbn VARCHAR(20) UNIQUE,
	title VARCHAR(200) NOT NULL,
	author VARCHAR(150) NOT NULL,
	publisher VARCHAR(150),
	publisher_year YEAR,
	description_b TEXT,
	cover_image VARCHAR(255),
	total_copies INT DEFAULT 0,
	available_copies INT DEFAULT 0,
	rack_location VARCHAR(50),
	status_b ENUM('available', 'unavailable') DEFAULT 'available',
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

	CONSTRAINT fk_books_categories
	FOREIGN KEY (categories_id) REFERENCES categories(id_categories)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);
CREATE TABLE books_copies (
	id_books_copies CHAR(36) PRIMARY KEY DEFAULT (UUID()),
	books_id CHAR(36) NOT NULL,
	barcode VARCHAR(100) UNIQUE,
	status_copy ENUM('available', 'borrowed', 'lost', 'damaged') DEFAULT 'available',
	condition_note TEXT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (books_id) REFERENCES books(id_books)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);
CREATE TABLE borrowings (
	id_borrowings CHAR(36) PRIMARY KEY DEFAULT (UUID()),
	details_users_id CHAR(36) NOT NULL,
	borrow_date DATE NOT NULL,
	due_date DATE NOT NULL,
	return_date DATE NULL,
	status_b ENUM('borrowed', 'returned', 'late') DEFAULT 'borrowed',
	fine_amount DECIMAL(10, 2) DEFAULT 0,
	handled_by CHAR(36) NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

	CONSTRAINT fk_borrowings_users_details
	FOREIGN KEY (details_users_id) REFERENCES users_details(id_users_details)
	ON DELETE CASCADE,

	CONSTRAINT fk_borrowings_users_account
	FOREIGN KEY (handled_by) REFERENCES users_account(id_users_account)
	ON DELETE SET NULL
);
CREATE TABLE borrowings_details (
	id_borrowings_details CHAR(36) PRIMARY KEY DEFAULT (UUID()),
	borrowings_id CHAR(36) NOT NULL,
	copies_books_id CHAR(36) NOT NULL,
	quantity INT DEFAULT 1,
	status_b ENUM('borrowed', 'returned', 'lost', 'damaged') DEFAULT 'borrowed',

	CONSTRAINT fk_borrowings_details_borrowings
	FOREIGN KEY (borrowings_id) REFERENCES borrowings(id_borrowings)
	ON DELETE CASCADE,

	CONSTRAINT fk_borrowings_details_books_copies
	FOREIGN KEY (copies_books_id) REFERENCES books_copies(id_books_copies)
	ON DELETE CASCADE
);
CREATE TABLE permissions (
	id_permissions CHAR(36) PRIMARY KEY DEFAULT (UUID()),
	permission_name VARCHAR(100) NOT NULL UNIQUE,
	description_p TEXT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE role_permissions (
	id_role_permissions CHAR(36) PRIMARY KEY DEFAULT (UUID()),
	roles_id CHAR(36) NOT NULL,
	permissions_id CHAR(36) NOT NULL,

	CONSTRAINT fk_role_permissions_roles
	FOREIGN KEY (roles_id) REFERENCES roles(id_roles)
	ON DELETE CASCADE,

	CONSTRAINT fk_role_permissions_permissions
	FOREIGN KEY (permissions_id) REFERENCES permissions(id_permissions)
	ON DELETE CASCADE,

	UNIQUE (roles_id, permissions_id)
);
CREATE TABLE activity_logs (
	id_activity_logs CHAR(36) PRIMARY KEY DEFAULT (UUID()),
	account_users_id CHAR(36) NOT NULL,
	action_a VARCHAR(255) NOT NULL,
	description_logs TEXT NULL,
	ip_address VARCHAR(45) NULL,
	users_agent TEXT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT fk_activity_logs_users_account
	FOREIGN KEY (account_users_id) REFERENCES users_account(id_users_account)
	ON DELETE CASCADE
);
CREATE TABLE password_resets (
	id_password_resets CHAR(36) PRIMARY KEY DEFAULT (UUID()),
	account_users_id CHAR(36) NOT NULL,
	reset_token VARCHAR(255) NOT NULL,
	expired_at DATETIME NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT fk_password_resets_users_account
	FOREIGN KEY (account_users_id) REFERENCES users_account(id_users_account)
	ON DELETE CASCADE
);
CREATE TABLE login_attempts (
	id_login_attempts CHAR(36) PRIMARY KEY DEFAULT (UUID()),
	email VARCHAR(150) NOT NULL,
	ip_address VARCHAR(45) NOT NULL,
	users_agent TEXT NULL,
	success BOOLEAN DEFAULT FALSE,
	attempt_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE reservations (
	id_reservations CHAR(36) PRIMARY KEY DEFAULT (UUID()),
	details_users_id CHAR(36) NOT NULL,
	books_id CHAR(36) NOT NULL,
	reservation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
	status_r ENUM('waiting', 'ready', 'cancelled', 'completed') DEFAULT 'waiting',

	FOREIGN KEY (details_users_id) REFERENCES users_details(id_users_details),
	FOREIGN KEY (books_id) REFERENCES books(id_books)
);
CREATE TABLE fines (
	id_fines CHAR(36) PRIMARY KEY DEFAULT (UUID()),
	borrowings_id CHAR(36) NOT NULL,
	amount DECIMAL(10,2) NOT NULL,
	status_f ENUM('unpaid', 'paid') DEFAULT 'unpaid',
	paid_at DATETIME NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	FOREIGN KEY (borrowings_id) REFERENCES borrowings(id_borrowings)
	ON DELETE CASCADE
);
CREATE TABLE books_reviews (
	id_books_reviews CHAR(36) PRIMARY KEY DEFAULT (UUID()),
	books_id CHAR(36) NOT NULL,
	details_users_id CHAR(36) NOT NULL,
	rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
	review TEXT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

	CONSTRAINT fk_books_reviews_books
	FOREIGN KEY (books_id) REFERENCES books(id_books)
	ON DELETE CASCADE,

	CONSTRAINT fk_books_reviews_users_details
	FOREIGN KEY (details_users_id) REFERENCES users_details(id_users_details)
	ON DELETE CASCADE,

	UNIQUE (books_id, details_users_id)
);