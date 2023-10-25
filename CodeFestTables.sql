-- MySQL Script generated by MySQL Workbench
-- Wed Oct 25 09:06:37 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`TipoUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TipoUser` (
  `idTipoUser` INT NOT NULL,
  `Admin` TINYINT NOT NULL,
  PRIMARY KEY (`idTipoUser`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuarios` (
  `IdUsuario` INT NOT NULL AUTO_INCREMENT,
  `Nombres` VARCHAR(45) NOT NULL,
  `Apellidos` VARCHAR(45) NOT NULL,
  `Fecha` DATE NOT NULL,
  `Tipo_Doc` VARCHAR(45) NOT NULL,
  `Identificacion` INT NOT NULL,
  `Lugar` VARCHAR(45) NOT NULL,
  `Correo` VARCHAR(45) NOT NULL,
  `Celular` INT NOT NULL,
  `Contraseña` VARCHAR(45) NOT NULL,
  `TipoUser_idTipoUser` INT NOT NULL,
  PRIMARY KEY (`IdUsuario`),
  UNIQUE INDEX `IdUsuario_UNIQUE` (`IdUsuario` ASC) VISIBLE,
  UNIQUE INDEX `Identificacion_UNIQUE` (`Identificacion` ASC) VISIBLE,
  UNIQUE INDEX `Celular_UNIQUE` (`Celular` ASC) VISIBLE,
  INDEX `fk_Usuarios_TipoUser1_idx` (`TipoUser_idTipoUser` ASC) VISIBLE,
  CONSTRAINT `fk_Usuarios_TipoUser1`
    FOREIGN KEY (`TipoUser_idTipoUser`)
    REFERENCES `mydb`.`TipoUser` (`idTipoUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Grupos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Grupos` (
  `IdGrupos` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Usuarios_IdUsuario` INT NOT NULL,
  PRIMARY KEY (`IdGrupos`),
  UNIQUE INDEX `IdGrupos_UNIQUE` (`IdGrupos` ASC) VISIBLE,
  INDEX `fk_Grupos_Usuarios_idx` (`Usuarios_IdUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Grupos_Usuarios`
    FOREIGN KEY (`Usuarios_IdUsuario`)
    REFERENCES `mydb`.`Usuarios` (`IdUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Publicaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Publicaciones` (
  `idPublicaciones` INT NOT NULL AUTO_INCREMENT,
  `Titulo` VARCHAR(45) NULL,
  `Descripcion` VARCHAR(45) NULL,
  `Video` VARCHAR(45) NULL,
  `Imagen` VARCHAR(45) NULL,
  PRIMARY KEY (`idPublicaciones`),
  UNIQUE INDEX `idPublicaciones_UNIQUE` (`idPublicaciones` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Grupos_has_Publicaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Grupos_has_Publicaciones` (
  `Grupos_IdGrupos` INT NOT NULL,
  `Publicaciones_idPublicaciones` INT NOT NULL,
  PRIMARY KEY (`Grupos_IdGrupos`, `Publicaciones_idPublicaciones`),
  INDEX `fk_Grupos_has_Publicaciones_Publicaciones1_idx` (`Publicaciones_idPublicaciones` ASC) VISIBLE,
  INDEX `fk_Grupos_has_Publicaciones_Grupos1_idx` (`Grupos_IdGrupos` ASC) VISIBLE,
  CONSTRAINT `fk_Grupos_has_Publicaciones_Grupos1`
    FOREIGN KEY (`Grupos_IdGrupos`)
    REFERENCES `mydb`.`Grupos` (`IdGrupos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Grupos_has_Publicaciones_Publicaciones1`
    FOREIGN KEY (`Publicaciones_idPublicaciones`)
    REFERENCES `mydb`.`Publicaciones` (`idPublicaciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;