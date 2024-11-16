CREATE TABLE IF NOT EXISTS `player_crypto` (
    `player_id` INT UNSIGNED NOT NULL,
    `crypto_balance` DECIMAL(15, 8) DEFAULT 0.0,
    PRIMARY KEY (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `gangs` (
    `gang_id` INT UNSIGNED AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `abbreviation` VARCHAR(5) NOT NULL,
    `color` VARCHAR(7) NOT NULL,
    `leader_id` INT UNSIGNED NOT NULL,
    `member_count` INT UNSIGNED DEFAULT 0,
    PRIMARY KEY (`gang_id`),
    UNIQUE (`abbreviation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `gang_members` (
    `gang_id` INT UNSIGNED NOT NULL,
    `player_id` INT UNSIGNED NOT NULL,
    `rank` VARCHAR(255) DEFAULT 'Member',
    PRIMARY KEY (`gang_id`, `player_id`),
    FOREIGN KEY (`gang_id`) REFERENCES `gangs`(`gang_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `market_items` (
    `item_id` INT UNSIGNED AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT,
    `price` DECIMAL(10, 2) NOT NULL,
    `image_url` VARCHAR(255),
    `quantity` INT UNSIGNED DEFAULT 0,
    PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

