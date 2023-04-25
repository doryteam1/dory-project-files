-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bd_prod
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bd_prod` ;

-- -----------------------------------------------------
-- Schema bd_prod
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bd_prod` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
USE `bd_prod` ;

-- -----------------------------------------------------
-- Table `bd_prod`.`grupos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`grupos` (
  `id` INT(11) NOT NULL,
  `fecha_creacion` DATETIME NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`areas_experticias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`areas_experticias` (
  `id_area` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_area`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`departamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`departamentos` (
  `id_departamento` INT(11) NOT NULL,
  `nombre_departamento` VARCHAR(45) NOT NULL,
  `descripcion` TEXT NOT NULL,
  PRIMARY KEY (`id_departamento`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`subregiones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`subregiones` (
  `id_subregion` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `id_departamento_fk` INT(11) NOT NULL,
  PRIMARY KEY (`id_subregion`),
  INDEX `fk_SUBREGIONES_DEPARTAMENTOS1_idx` (`id_departamento_fk` ASC) ,
  CONSTRAINT `fk_subregiones_departamentos1`
    FOREIGN KEY (`id_departamento_fk`)
    REFERENCES `bd_prod`.`departamentos` (`id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`municipios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`municipios` (
  `id_municipio` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `poblacion` INT(11) NOT NULL,
  `id_departamento_fk` INT(11) NOT NULL,
  `id_subregion_fk` INT(11) NULL DEFAULT NULL,
  `latitud` DECIMAL(10,8) NULL DEFAULT NULL,
  `longitud` DECIMAL(10,8) NULL DEFAULT NULL,
  PRIMARY KEY (`id_municipio`),
  INDEX `fk_MUNICIPIOS_DEPARTAMENTOS1_idx` (`id_departamento_fk` ASC) ,
  INDEX `fk_MUNICIPIOS_SUBREGIONES1_idx` (`id_subregion_fk` ASC) ,
  CONSTRAINT `fk_municipios_departamentos1`
    FOREIGN KEY (`id_departamento_fk`)
    REFERENCES `bd_prod`.`departamentos` (`id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_municipios_subregiones1`
    FOREIGN KEY (`id_subregion_fk`)
    REFERENCES `bd_prod`.`subregiones` (`id_subregion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`corregimientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`corregimientos` (
  `id_corregimiento` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `id_municipio` INT(11) NOT NULL,
  PRIMARY KEY (`id_corregimiento`),
  INDEX `fk_CORREGIMIENTOS_MUNICIPIOS1_idx` (`id_municipio` ASC) ,
  CONSTRAINT `fk_CORREGIMIENTOS_MUNICIPIOS1`
    FOREIGN KEY (`id_municipio`)
    REFERENCES `bd_prod`.`municipios` (`id_municipio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`etnias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`etnias` (
  `id` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`sexos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`sexos` (
  `id` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`tipos_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`tipos_usuarios` (
  `id_tipo_usuario` INT(10) NOT NULL,
  `nombre_tipo_usuario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tipo_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`veredas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`veredas` (
  `id_vereda` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `id_municipio` INT(11) NOT NULL,
  `id_corregimiento_fk` INT(11) NOT NULL,
  PRIMARY KEY (`id_vereda`),
  INDEX `fk_VEREDAS_MUNICIPIOS1_idx` (`id_municipio` ASC) ,
  INDEX `fk_VEREDAS_CORREGIMIENTOS1_idx` (`id_corregimiento_fk` ASC) ,
  CONSTRAINT `fk_veredas_corregimientos1`
    FOREIGN KEY (`id_corregimiento_fk`)
    REFERENCES `bd_prod`.`corregimientos` (`id_corregimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_veredas_municipios1`
    FOREIGN KEY (`id_municipio`)
    REFERENCES `bd_prod`.`municipios` (`id_municipio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`usuarios` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `cedula` VARCHAR(45) NULL DEFAULT NULL,
  `nombres` VARCHAR(45) NULL DEFAULT NULL,
  `apellidos` VARCHAR(45) NULL DEFAULT NULL,
  `celular` VARCHAR(45) NULL DEFAULT NULL,
  `direccion` VARCHAR(45) NULL DEFAULT NULL,
  `id_tipo_usuario` INT(11) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `password` VARCHAR(60) NULL DEFAULT NULL,
  `id_area_experticia` INT(11) NULL DEFAULT NULL,
  `nombre_negocio` VARCHAR(45) NULL DEFAULT NULL,
  `foto` TEXT NULL DEFAULT NULL,
  `fecha_registro` DATE NULL DEFAULT NULL,
  `fecha_nacimiento` DATE NULL DEFAULT NULL,
  `id_departamento` INT(11) NULL DEFAULT NULL,
  `id_municipio` INT(11) NULL DEFAULT NULL,
  `id_corregimiento` INT(11) NULL DEFAULT NULL,
  `id_vereda` INT(11) NULL DEFAULT NULL,
  `latitud` DECIMAL(10,8) NULL DEFAULT NULL,
  `longitud` DECIMAL(10,8) NULL DEFAULT NULL,
  `nombre_corregimiento` VARCHAR(45) NULL DEFAULT NULL,
  `nombre_vereda` VARCHAR(45) NULL DEFAULT NULL,
  `estaVerificado` TINYINT(1) NULL DEFAULT NULL,
  `otra_area_experticia` VARCHAR(45) NULL DEFAULT NULL,
  `otra_area_experticia_descripcion` VARCHAR(45) NULL DEFAULT NULL,
  `sobre_mi` VARCHAR(45) NULL DEFAULT NULL,
  `informacion_adicional_direccion` TEXT NULL DEFAULT NULL,
  `creadoCon` VARCHAR(45) NULL DEFAULT NULL,
  `takeTour` TINYINT(1) NULL DEFAULT 0,
  `id_sexo` INT(11) NULL DEFAULT NULL,
  `id_etnia` INT(11) NULL DEFAULT NULL,
  `url_sisben` TEXT NULL DEFAULT NULL,
  `url_imagen_cedula` TEXT NULL DEFAULT NULL,
  `carnet` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) ,
  INDEX `fk_Usuario_Tipo_Usuario_idx` (`id_tipo_usuario` ASC) ,
  INDEX `id_sexo` (`id_sexo` ASC) ,
  INDEX `id_etnia` (`id_etnia` ASC) ,
  INDEX `id_area_experticia` (`id_area_experticia` ASC) ,
  INDEX `fk_usuarios_municipios12` (`id_municipio` ASC) ,
  INDEX `fk_usuarios_departamentos1` (`id_departamento` ASC) ,
  INDEX `fk_usuarios_veredas1` (`id_vereda` ASC) ,
  INDEX `fk_usuarios_corregimientos1` (`id_corregimiento` ASC) ,
  CONSTRAINT `fk_usuarios_areas_experticias1`
    FOREIGN KEY (`id_area_experticia`)
    REFERENCES `bd_prod`.`areas_experticias` (`id_area`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_corregimientos1`
    FOREIGN KEY (`id_corregimiento`)
    REFERENCES `bd_prod`.`corregimientos` (`id_corregimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_departamentos1`
    FOREIGN KEY (`id_departamento`)
    REFERENCES `bd_prod`.`departamentos` (`id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_etnias1`
    FOREIGN KEY (`id_etnia`)
    REFERENCES `bd_prod`.`etnias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_municipios12`
    FOREIGN KEY (`id_municipio`)
    REFERENCES `bd_prod`.`municipios` (`id_municipio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_sexos1`
    FOREIGN KEY (`id_sexo`)
    REFERENCES `bd_prod`.`sexos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_tipos_usuarios1`
    FOREIGN KEY (`id_tipo_usuario`)
    REFERENCES `bd_prod`.`tipos_usuarios` (`id_tipo_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_veredas1`
    FOREIGN KEY (`id_vereda`)
    REFERENCES `bd_prod`.`veredas` (`id_vereda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`administradores_grupos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`administradores_grupos` (
  `grupos_id` INT(11) NOT NULL,
  `usuarios_id` INT(11) NOT NULL,
  PRIMARY KEY (`grupos_id`, `usuarios_id`),
  INDEX `fk_grupos_has_usuarios_usuarios1_idx` (`usuarios_id` ASC) ,
  INDEX `fk_grupos_has_usuarios_grupos1_idx` (`grupos_id` ASC) ,
  CONSTRAINT `fk_grupos_has_usuarios_grupos1`
    FOREIGN KEY (`grupos_id`)
    REFERENCES `bd_prod`.`grupos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grupos_has_usuarios_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `bd_prod`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`tipos_asociaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`tipos_asociaciones` (
  `id_tipo_asociacion` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_tipo_asociacion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`asociaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`asociaciones` (
  `nit` BIGINT(20) NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `direccion` TEXT NULL DEFAULT NULL,
  `legalconstituida` INT(11) NULL DEFAULT NULL,
  `fecha_renovacion_camarac` DATE NULL DEFAULT NULL,
  `foto_camarac` TEXT NULL DEFAULT NULL,
  `id_tipo_asociacion_fk` INT(11) NULL DEFAULT NULL,
  `id_departamento` INT(11) NULL DEFAULT NULL,
  `id_municipio` INT(11) NULL DEFAULT NULL,
  `id_corregimiento` INT(11) NULL DEFAULT NULL,
  `id_vereda` INT(11) NULL DEFAULT NULL,
  `informacion_adicional_direccion` TEXT NULL DEFAULT NULL,
  `corregimiento_vereda` VARCHAR(45) NULL DEFAULT NULL,
  `telefono` VARCHAR(45) NULL DEFAULT NULL,
  `url_rut` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`nit`),
  INDEX `fk_ASOCIACIONES_TIPOS_ASOCIACIONES1_idx` (`id_tipo_asociacion_fk` ASC) ,
  INDEX `fk_ASOCIACIONES_VEREDAS1_idx` (`id_vereda` ASC) ,
  INDEX `fk_ASOCIACIONES_MUNICIPIOS1_idx` (`id_municipio` ASC) ,
  INDEX `fk_ASOCIACIONES_DEPARTAMENTOS1_idx` (`id_departamento` ASC) ,
  INDEX `fk_ASOCIACIONES_CORREGIMIENTOS1_idx` (`id_corregimiento` ASC) ,
  CONSTRAINT `fk_ASOCIACIONES_CORREGIMIENTOS1`
    FOREIGN KEY (`id_corregimiento`)
    REFERENCES `bd_prod`.`corregimientos` (`id_corregimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ASOCIACIONES_DEPARTAMENTOS1`
    FOREIGN KEY (`id_departamento`)
    REFERENCES `bd_prod`.`departamentos` (`id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ASOCIACIONES_MUNICIPIOS1`
    FOREIGN KEY (`id_municipio`)
    REFERENCES `bd_prod`.`municipios` (`id_municipio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ASOCIACIONES_TIPOS_ASOCIACIONES1`
    FOREIGN KEY (`id_tipo_asociacion_fk`)
    REFERENCES `bd_prod`.`tipos_asociaciones` (`id_tipo_asociacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ASOCIACIONES_VEREDAS1`
    FOREIGN KEY (`id_vereda`)
    REFERENCES `bd_prod`.`veredas` (`id_vereda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`asociaciones_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`asociaciones_usuarios` (
  `nit_asociacion_pk_fk` BIGINT(20) NOT NULL,
  `usuarios_id` INT(11) NOT NULL,
  PRIMARY KEY (`nit_asociacion_pk_fk`, `usuarios_id`),
  INDEX `fk_USUARIOS_has_ASOCIACIONES_ASOCIACIONES1_idx` (`nit_asociacion_pk_fk` ASC) ,
  INDEX `fk_asociaciones_usuarios_usuarios1_idx` (`usuarios_id` ASC) ,
  CONSTRAINT `fk_USUARIOS_has_ASOCIACIONES_ASOCIACIONES1`
    FOREIGN KEY (`nit_asociacion_pk_fk`)
    REFERENCES `bd_prod`.`asociaciones` (`nit`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asociaciones_usuarios_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `bd_prod`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`categorias` (
  `id_categoria` INT(10) NOT NULL,
  `nombre_categoria` VARCHAR(45) NOT NULL,
  `descripcion_categoria` TEXT NOT NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`modalidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`modalidades` (
  `id_modalidad` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_modalidad`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`tipos_eventos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`tipos_eventos` (
  `id_evento` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_evento`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`eventos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`eventos` (
  `id_evento` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` TEXT NOT NULL,
  `resumen` TEXT NOT NULL,
  `fecha` DATE NULL DEFAULT NULL,
  `hora` TIME NULL DEFAULT NULL,
  `imagen` TEXT NULL DEFAULT NULL,
  `url` TEXT NULL DEFAULT NULL,
  `dirigidoa` TEXT NULL DEFAULT NULL,
  `organizador` TEXT NULL DEFAULT NULL,
  `costo` VARCHAR(45) NULL DEFAULT NULL,
  `id_modalidad_fk` INT(11) NULL DEFAULT NULL,
  `id_tipo_evento_fk` INT(11) NOT NULL,
  PRIMARY KEY (`id_evento`),
  INDEX `fk_EVENTOS_TIPO_EVENTO1_idx` (`id_tipo_evento_fk` ASC) ,
  INDEX `fk_EVENTOS_MODALIDADES1_idx` (`id_modalidad_fk` ASC) ,
  CONSTRAINT `fk_EVENTOS_MODALIDADES1`
    FOREIGN KEY (`id_modalidad_fk`)
    REFERENCES `bd_prod`.`modalidades` (`id_modalidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EVENTOS_TIPO_EVENTO1`
    FOREIGN KEY (`id_tipo_evento_fk`)
    REFERENCES `bd_prod`.`tipos_eventos` (`id_evento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`categorias_eventos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`categorias_eventos` (
  `id_categoria_pk_fk` INT(10) NOT NULL,
  `id_evento_pk_fk` INT(11) NOT NULL,
  PRIMARY KEY (`id_categoria_pk_fk`, `id_evento_pk_fk`),
  INDEX `fk_CATEGORIAS_has_EVENTOS_EVENTOS1_idx` (`id_evento_pk_fk` ASC) ,
  INDEX `fk_CATEGORIAS_has_EVENTOS_CATEGORIAS1_idx` (`id_categoria_pk_fk` ASC) ,
  CONSTRAINT `fk_CATEGORIAS_has_EVENTOS_CATEGORIAS1`
    FOREIGN KEY (`id_categoria_pk_fk`)
    REFERENCES `bd_prod`.`categorias` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CATEGORIAS_has_EVENTOS_EVENTOS1`
    FOREIGN KEY (`id_evento_pk_fk`)
    REFERENCES `bd_prod`.`eventos` (`id_evento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`tipos_novedades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`tipos_novedades` (
  `id_tipo_novedad` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tipo_novedad`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`novedades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`novedades` (
  `id_novedad` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` TEXT NOT NULL,
  `autor` TEXT NULL DEFAULT NULL,
  `cuerpo` TEXT NULL DEFAULT NULL,
  `fecha_creacion` TIMESTAMP NULL DEFAULT NULL,
  `resumen` TEXT NULL DEFAULT NULL,
  `cant_visitas` INT(11) NOT NULL,
  `url_foto_autor` TEXT NULL DEFAULT NULL,
  `url_foto_novedad` TEXT NULL DEFAULT NULL,
  `url_novedad` TEXT NULL DEFAULT NULL,
  `canal` VARCHAR(45) NULL DEFAULT NULL,
  `email_autor` TEXT NULL DEFAULT NULL,
  `id_tipo_novedad` INT(11) NOT NULL,
  `usuarios_id` INT(11) NOT NULL,
  PRIMARY KEY (`id_novedad`),
  INDEX `fk_NOVEDADES_TIPOS_NOVEDADES1_idx` (`id_tipo_novedad` ASC) ,
  INDEX `fk_novedades_usuarios1_idx` (`usuarios_id` ASC) ,
  CONSTRAINT `fk_novedades_tipos_novedades1`
    FOREIGN KEY (`id_tipo_novedad`)
    REFERENCES `bd_prod`.`tipos_novedades` (`id_tipo_novedad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_novedades_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `bd_prod`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`categorias_novedades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`categorias_novedades` (
  `id_categoria_pk_fk` INT(10) NOT NULL,
  `id_novedad_pk_fk` INT(11) NOT NULL,
  PRIMARY KEY (`id_categoria_pk_fk`, `id_novedad_pk_fk`),
  INDEX `fk_CATEGORIAS_has_NOVEDADES_NOVEDADES1_idx` (`id_novedad_pk_fk` ASC) ,
  INDEX `fk_CATEGORIAS_has_NOVEDADES_CATEGORIAS1_idx` (`id_categoria_pk_fk` ASC) ,
  CONSTRAINT `fk_CATEGORIAS_has_NOVEDADES_CATEGORIAS1`
    FOREIGN KEY (`id_categoria_pk_fk`)
    REFERENCES `bd_prod`.`categorias` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CATEGORIAS_has_NOVEDADES_NOVEDADES1`
    FOREIGN KEY (`id_novedad_pk_fk`)
    REFERENCES `bd_prod`.`novedades` (`id_novedad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`conocenos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`conocenos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` TEXT NULL DEFAULT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`integrantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`integrantes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombres` VARCHAR(45) NULL DEFAULT NULL,
  `apellidos` VARCHAR(45) NULL DEFAULT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  `imagen` TEXT NULL DEFAULT NULL,
  `fecha_nacimiento` DATE NULL DEFAULT NULL,
  `cargo` VARCHAR(45) NULL DEFAULT NULL,
  `municipio` VARCHAR(45) NULL DEFAULT NULL,
  `departamento` VARCHAR(45) NULL DEFAULT NULL,
  `pais` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`enlaces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`enlaces` (
  `id_enlace` INT(11) NOT NULL AUTO_INCREMENT,
  `url_enlace` TEXT NULL DEFAULT NULL,
  `id_integrante` INT(11) NOT NULL,
  PRIMARY KEY (`id_enlace`),
  INDEX `fk_enlaces_integrantes1_idx` (`id_integrante` ASC) ,
  CONSTRAINT `fk_enlaces_integrantes1`
    FOREIGN KEY (`id_integrante`)
    REFERENCES `bd_prod`.`integrantes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`enlaces_rapidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`enlaces_rapidos` (
  `id_enlace_rapido` INT(11) NOT NULL AUTO_INCREMENT,
  `url_imagen` TEXT NULL DEFAULT NULL,
  `url_enlace` TEXT NULL DEFAULT NULL,
  `titulo` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_enlace_rapido`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`especies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`especies` (
  `id_especie` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `imagen` TEXT NOT NULL,
  PRIMARY KEY (`id_especie`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`granjas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`granjas` (
  `id_granja` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `area` INT(11) NULL DEFAULT NULL,
  `numero_trabajadores` INT(11) NULL DEFAULT NULL,
  `produccion_estimada_mes` FLOAT NULL DEFAULT NULL,
  `direccion` VARCHAR(45) NULL DEFAULT NULL,
  `latitud` DECIMAL(10,8) NULL DEFAULT NULL,
  `longitud` DECIMAL(10,8) NULL DEFAULT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  `id_departamento` INT(11) NULL DEFAULT NULL,
  `id_municipio` INT(11) NULL DEFAULT NULL,
  `id_corregimiento` INT(11) NULL DEFAULT NULL,
  `id_vereda` INT(11) NULL DEFAULT NULL,
  `corregimiento_vereda` VARCHAR(45) NULL DEFAULT NULL,
  `informacion_adicional_direccion` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_granja`),
  INDEX `fk_GRANJAS_VEREDAS1_idx` (`id_vereda` ASC) ,
  INDEX `fk_GRANJAS_CORREGIMIENTOS1_idx` (`id_corregimiento` ASC) ,
  INDEX `fk_GRANJAS_MUNICIPIOS1_idx` (`id_municipio` ASC) ,
  INDEX `fk_GRANJAS_DEPARTAMENTOS1_idx` (`id_departamento` ASC) ,
  CONSTRAINT `fk_GRANJAS_DEPARTAMENTOS1`
    FOREIGN KEY (`id_departamento`)
    REFERENCES `bd_prod`.`departamentos` (`id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GRANJAS_MUNICIPIOS1`
    FOREIGN KEY (`id_municipio`)
    REFERENCES `bd_prod`.`municipios` (`id_municipio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_granjas_corregimientos1`
    FOREIGN KEY (`id_corregimiento`)
    REFERENCES `bd_prod`.`corregimientos` (`id_corregimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_granjas_veredas1`
    FOREIGN KEY (`id_vereda`)
    REFERENCES `bd_prod`.`veredas` (`id_vereda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`especies_granjas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`especies_granjas` (
  `id_especie_pk_fk` INT(11) NOT NULL,
  `id_granja_pk_fk` INT(11) NOT NULL,
  PRIMARY KEY (`id_especie_pk_fk`, `id_granja_pk_fk`),
  INDEX `fk_Especies_has_Granja_Granja1_idx` (`id_granja_pk_fk` ASC) ,
  INDEX `fk_Especies_has_Granja_Especies1_idx` (`id_especie_pk_fk` ASC) ,
  CONSTRAINT `fk_Especies_has_Granja_Especies1`
    FOREIGN KEY (`id_especie_pk_fk`)
    REFERENCES `bd_prod`.`especies` (`id_especie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Especies_has_Granja_Granja1`
    FOREIGN KEY (`id_granja_pk_fk`)
    REFERENCES `bd_prod`.`granjas` (`id_granja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`especies_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`especies_usuarios` (
  `id_especie_pk_fk` INT(11) NOT NULL,
  `usuarios_id` INT(11) NOT NULL,
  `cantidad_consumo` FLOAT NULL DEFAULT NULL,
  `fecha_consumo` DATE NOT NULL,
  PRIMARY KEY (`id_especie_pk_fk`, `usuarios_id`, `fecha_consumo`),
  INDEX `fk_USUARIO_has_ESPECIE_ESPECIE1_idx` (`id_especie_pk_fk` ASC) ,
  INDEX `fk_especies_usuarios_usuarios1_idx` (`usuarios_id` ASC) ,
  CONSTRAINT `fk_USUARIO_has_ESPECIE_ESPECIE1`
    FOREIGN KEY (`id_especie_pk_fk`)
    REFERENCES `bd_prod`.`especies` (`id_especie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_especies_usuarios_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `bd_prod`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`estados_solicitudes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`estados_solicitudes` (
  `id_estado` INT(11) NOT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_estado`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bd_prod`.`fotos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`fotos` (
  `id_foto` INT(11) NOT NULL AUTO_INCREMENT,
  `imagen` TEXT NULL DEFAULT NULL,
  `id_granja_fk` INT(11) NOT NULL,
  PRIMARY KEY (`id_foto`),
  INDEX `fk_FOTOS_GRANJAS1_idx` (`id_granja_fk` ASC) ,
  CONSTRAINT `fk_FOTOS_GRANJAS1`
    FOREIGN KEY (`id_granja_fk`)
    REFERENCES `bd_prod`.`granjas` (`id_granja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`negocios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`negocios` (
  `id_negocio` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre_negocio` VARCHAR(45) NULL DEFAULT NULL,
  `descripcion_negocio` TEXT NULL DEFAULT NULL,
  `usuarios_id` INT(11) NULL DEFAULT NULL,
  `id_departamento` INT(11) NULL DEFAULT NULL,
  `id_municipio` INT(11) NULL DEFAULT NULL,
  `direccion` VARCHAR(45) NULL DEFAULT NULL,
  `latitud` DECIMAL(10,8) NULL DEFAULT NULL,
  `longitud` DECIMAL(10,8) NULL DEFAULT NULL,
  `informacion_adicional_direccion` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_negocio`),
  INDEX `fk_negocios_usuarios1` (`usuarios_id` ASC) ,
  INDEX `fk_negocios_departamentos1` (`id_departamento` ASC) ,
  INDEX `fk_negocios_municipios1` (`id_municipio` ASC) ,
  CONSTRAINT `fk_negocios_departamentos1`
    FOREIGN KEY (`id_departamento`)
    REFERENCES `bd_prod`.`departamentos` (`id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_negocios_municipios1`
    FOREIGN KEY (`id_municipio`)
    REFERENCES `bd_prod`.`municipios` (`id_municipio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_negocios_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `bd_prod`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`fotosNegocios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`fotosNegocios` (
  `id_foto_negocio` INT(11) NOT NULL AUTO_INCREMENT,
  `foto_negocio` TEXT NULL DEFAULT NULL,
  `id_negocio_fk` INT(11) NOT NULL,
  PRIMARY KEY (`id_foto_negocio`),
  INDEX `fk_FOTOS_NEGOCIOS` (`id_negocio_fk` ASC) ,
  CONSTRAINT `fk_FOTOS_NEGOCIOS`
    FOREIGN KEY (`id_negocio_fk`)
    REFERENCES `bd_prod`.`negocios` (`id_negocio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`productos` (
  `codigo` INT(11) NOT NULL AUTO_INCREMENT,
  `nombreProducto` VARCHAR(45) NOT NULL,
  `precio` FLOAT NULL DEFAULT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  `imagen` TEXT NULL DEFAULT NULL,
  `usuarios_id` INT(11) NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_USUARIOS` (`usuarios_id` ASC) ,
  CONSTRAINT `fk_productos_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `bd_prod`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`fotosProductos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`fotosProductos` (
  `id_foto_producto` INT(11) NOT NULL AUTO_INCREMENT,
  `foto` TEXT NULL DEFAULT NULL,
  `codigo_producto_fk` INT(11) NOT NULL,
  PRIMARY KEY (`id_foto_producto`),
  INDEX `fk_FOTOS_PRODUCTOS` (`codigo_producto_fk` ASC) ,
  CONSTRAINT `fk_FOTOS_PRODUCTOS`
    FOREIGN KEY (`codigo_producto_fk`)
    REFERENCES `bd_prod`.`productos` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`vehiculos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`vehiculos` (
  `id_vehiculo` INT(10) NOT NULL AUTO_INCREMENT,
  `capacidad` VARCHAR(45) NULL DEFAULT NULL,
  `modelo` VARCHAR(45) NULL DEFAULT NULL,
  `transporte_alimento` INT(11) NULL DEFAULT NULL,
  `usuarios_id` INT(11) NOT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_vehiculo`),
  INDEX `fk_vehiculos_usuarios1_idx` (`usuarios_id` ASC) ,
  CONSTRAINT `fk_vehiculos_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `bd_prod`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`fotosVehiculos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`fotosVehiculos` (
  `id_fotov` INT(11) NOT NULL AUTO_INCREMENT,
  `fotov` TEXT NULL DEFAULT NULL,
  `id_vehiculo_fk` INT(11) NOT NULL,
  PRIMARY KEY (`id_fotov`),
  INDEX `fk_FOTOS_VEHICULOS` (`id_vehiculo_fk` ASC) ,
  CONSTRAINT `fk_FOTOS_VEHICULOS`
    FOREIGN KEY (`id_vehiculo_fk`)
    REFERENCES `bd_prod`.`vehiculos` (`id_vehiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`preguntasforos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`preguntasforos` (
  `id_preguntaf` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` TEXT NULL DEFAULT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  `fecha` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `usuarios_id` INT(11) NOT NULL,
  PRIMARY KEY (`id_preguntaf`),
  INDEX `fk_preguntasforos_usuarios_idx` (`usuarios_id` ASC) ,
  CONSTRAINT `fk_preguntasforos_usuarios`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `bd_prod`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`fotospreguntas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`fotospreguntas` (
  `idfotopf` INT(11) NOT NULL AUTO_INCREMENT,
  `fotopf` TEXT NULL DEFAULT NULL,
  `id_preguntaf` INT(11) NOT NULL,
  PRIMARY KEY (`idfotopf`),
  INDEX `fk_fotospreguntas_preguntasforos1_idx` (`id_preguntaf` ASC) ,
  CONSTRAINT `fk_fotospreguntas_preguntasforos1`
    FOREIGN KEY (`id_preguntaf`)
    REFERENCES `bd_prod`.`preguntasforos` (`id_preguntaf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`publicaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`publicaciones` (
  `id_publicacion` INT(11) NOT NULL AUTO_INCREMENT,
  `cantidad` INT(11) NULL DEFAULT NULL,
  `preciokilogramo` FLOAT NULL DEFAULT NULL,
  `id_especie_fk` INT(11) NOT NULL,
  `id_municipio_fk` INT(11) NOT NULL,
  `usuarios_id` INT(11) NOT NULL,
  `titulo` VARCHAR(45) NULL DEFAULT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  `fecha` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  PRIMARY KEY (`id_publicacion`),
  INDEX `fk_publicaciones_especies1_idx` (`id_especie_fk` ASC) ,
  INDEX `fk_publicaciones_municipios1_idx` (`id_municipio_fk` ASC) ,
  INDEX `fk_publicaciones_usuarios1_idx` (`usuarios_id` ASC) ,
  CONSTRAINT `fk_publicaciones_especies1`
    FOREIGN KEY (`id_especie_fk`)
    REFERENCES `bd_prod`.`especies` (`id_especie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_publicaciones_municipios1`
    FOREIGN KEY (`id_municipio_fk`)
    REFERENCES `bd_prod`.`municipios` (`id_municipio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_publicaciones_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `bd_prod`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`fotospublicaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`fotospublicaciones` (
  `id_foto_publicacion` INT(11) NOT NULL AUTO_INCREMENT,
  `fotop` TEXT NULL DEFAULT NULL,
  `id_publicacion_fk` INT(11) NOT NULL,
  PRIMARY KEY (`id_foto_publicacion`),
  INDEX `fk_fotospublicaciones_publicaciones1_idx` (`id_publicacion_fk` ASC) ,
  CONSTRAINT `fk_fotospublicaciones_publicaciones1`
    FOREIGN KEY (`id_publicacion_fk`)
    REFERENCES `bd_prod`.`publicaciones` (`id_publicacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`respuestasforos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`respuestasforos` (
  `idrespuestaf` INT(11) NOT NULL AUTO_INCREMENT,
  `usuarios_id` INT(11) NOT NULL,
  `id_preguntaf` INT(11) NOT NULL,
  `fecha` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `respuesta` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`idrespuestaf`),
  INDEX `fk_respuestasforos_usuarios1_idx` (`usuarios_id` ASC) ,
  INDEX `fk_respuestasforos_preguntasforos1_idx` (`id_preguntaf` ASC) ,
  CONSTRAINT `fk_respuestasforos_preguntasforos1`
    FOREIGN KEY (`id_preguntaf`)
    REFERENCES `bd_prod`.`preguntasforos` (`id_preguntaf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_respuestasforos_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `bd_prod`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`fotosrespuestas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`fotosrespuestas` (
  `idfotorf` INT(11) NOT NULL AUTO_INCREMENT,
  `fotorf` TEXT NULL DEFAULT NULL,
  `id_respuestaf` INT(11) NOT NULL,
  PRIMARY KEY (`idfotorf`),
  INDEX `fk_fotosrespuestas_respuestasforos_idx` (`id_respuestaf` ASC) ,
  CONSTRAINT `fk_fotosrespuestas_respuestasforos`
    FOREIGN KEY (`id_respuestaf`)
    REFERENCES `bd_prod`.`respuestasforos` (`idrespuestaf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`indexs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`indexs` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `title` TEXT NULL DEFAULT NULL,
  `href` TEXT NULL DEFAULT NULL,
  `lastmodified` DATETIME NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`infraestructuras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`infraestructuras` (
  `id_infraestructura` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` TEXT NOT NULL,
  PRIMARY KEY (`id_infraestructura`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`infraestructuras_granjas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`infraestructuras_granjas` (
  `id_granja_pk_fk` INT(11) NOT NULL,
  `id_infraestructura_pk_fk` INT(11) NOT NULL,
  PRIMARY KEY (`id_granja_pk_fk`, `id_infraestructura_pk_fk`),
  INDEX `fk_Granja_has_Infraestructura_Infraestructura1_idx` (`id_infraestructura_pk_fk` ASC) ,
  INDEX `fk_Granja_has_Infraestructura_Granja1_idx` (`id_granja_pk_fk` ASC) ,
  CONSTRAINT `fk_Granja_has_Infraestructura_Granja1`
    FOREIGN KEY (`id_granja_pk_fk`)
    REFERENCES `bd_prod`.`granjas` (`id_granja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Granja_has_Infraestructura_Infraestructura1`
    FOREIGN KEY (`id_infraestructura_pk_fk`)
    REFERENCES `bd_prod`.`infraestructuras` (`id_infraestructura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`me_gustas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`me_gustas` (
  `id_novedad_pk_fk` INT(11) NOT NULL,
  `usuarios_id` INT(11) NOT NULL,
  PRIMARY KEY (`id_novedad_pk_fk`, `usuarios_id`),
  INDEX `fk_NOVEDADES_has_USUARIOS_NOVEDADES1_idx` (`id_novedad_pk_fk` ASC) ,
  INDEX `fk_me_gustas_usuarios1_idx` (`usuarios_id` ASC) ,
  CONSTRAINT `fk_NOVEDADES_has_USUARIOS_NOVEDADES1`
    FOREIGN KEY (`id_novedad_pk_fk`)
    REFERENCES `bd_prod`.`novedades` (`id_novedad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_me_gustas_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `bd_prod`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`tipo_mensaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`tipo_mensaje` (
  `id` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`mensajes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`mensajes` (
  `id_mensaje` INT(11) NOT NULL AUTO_INCREMENT,
  `contenido` TEXT NULL DEFAULT NULL,
  `fecha_creacion` TIMESTAMP NULL DEFAULT NULL,
  `usuario_emisor_id` INT(11) NULL DEFAULT NULL,
  `usuario_receptor_id` INT(11) NULL DEFAULT NULL,
  `tipo_mensaje_id` INT(11) NOT NULL,
  `grupos_id` INT(11) NULL DEFAULT NULL,
  `readed` TINYINT(4) NULL DEFAULT 0,
  PRIMARY KEY (`id_mensaje`),
  INDEX `fk_mensajes_usuarios1_idx` (`usuario_emisor_id` ASC) ,
  INDEX `fk_mensajes_usuarios2_idx` (`usuario_receptor_id` ASC) ,
  INDEX `fk_mensajes_tipo_mensaje1_idx` (`tipo_mensaje_id` ASC) ,
  INDEX `fk_mensajes_grupos1_idx` (`grupos_id` ASC) ,
  CONSTRAINT `fk_mensajes_grupos1`
    FOREIGN KEY (`grupos_id`)
    REFERENCES `bd_prod`.`grupos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mensajes_tipo_mensaje1`
    FOREIGN KEY (`tipo_mensaje_id`)
    REFERENCES `bd_prod`.`tipo_mensaje` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mensajes_usuarios1`
    FOREIGN KEY (`usuario_emisor_id`)
    REFERENCES `bd_prod`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mensajes_usuarios2`
    FOREIGN KEY (`usuario_receptor_id`)
    REFERENCES `bd_prod`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`tipos_normatividades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`tipos_normatividades` (
  `id_tipo` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tipo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`normatividades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`normatividades` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` TEXT NOT NULL,
  `contenido` TEXT NOT NULL,
  `url_descarga` TEXT NOT NULL,
  `id_tipo_fk` INT(11) NOT NULL,
  `fecha` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_NORMATIVIDAD_TIPO DE NORMATIVIDAD1_idx` (`id_tipo_fk` ASC) ,
  CONSTRAINT `fk_normatividades_tipos_normatividades1`
    FOREIGN KEY (`id_tipo_fk`)
    REFERENCES `bd_prod`.`tipos_normatividades` (`id_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`nosotros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`nosotros` (
  `id` INT(11) NOT NULL,
  `entidad` TEXT NULL DEFAULT NULL,
  `mision` TEXT NULL DEFAULT NULL,
  `vision` TEXT NULL DEFAULT NULL,
  `imagen_entidad` TEXT NULL DEFAULT NULL,
  `imagen_mision` TEXT NULL DEFAULT NULL,
  `imagen_vision` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`sectores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`sectores` (
  `id_sector` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_sector`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`proyectos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`proyectos` (
  `id_proyecto` INT(11) NOT NULL,
  `nombre` TEXT NOT NULL,
  `fecha_creacion` DATE NULL DEFAULT NULL,
  `formulador` TEXT NULL DEFAULT NULL,
  `codigo_bpin` VARCHAR(45) NULL DEFAULT NULL,
  `duracion_meses` INT(11) NULL DEFAULT NULL,
  `archivo` TEXT NULL DEFAULT NULL,
  `id_sector_fk` INT(11) NOT NULL,
  PRIMARY KEY (`id_proyecto`),
  INDEX `fk_proyectos_SECTORES1_idx` (`id_sector_fk` ASC) ,
  CONSTRAINT `fk_proyectos_sectores1`
    FOREIGN KEY (`id_sector_fk`)
    REFERENCES `bd_prod`.`sectores` (`id_sector`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`proyectos_departamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`proyectos_departamentos` (
  `id_proyecto_pk_fk` INT(11) NOT NULL,
  `id_departamento_pk_fk` INT(11) NOT NULL,
  PRIMARY KEY (`id_proyecto_pk_fk`, `id_departamento_pk_fk`),
  INDEX `fk_proyectos_has_DEPARTAMENTOS_DEPARTAMENTOS1_idx` (`id_departamento_pk_fk` ASC) ,
  INDEX `fk_proyectos_has_DEPARTAMENTOS_proyectos1_idx` (`id_proyecto_pk_fk` ASC) ,
  CONSTRAINT `fk_proyectos_departamentos_departamentos1`
    FOREIGN KEY (`id_departamento_pk_fk`)
    REFERENCES `bd_prod`.`departamentos` (`id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proyectos_departamentos_proyectos1`
    FOREIGN KEY (`id_proyecto_pk_fk`)
    REFERENCES `bd_prod`.`proyectos` (`id_proyecto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`proyectos_municipios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`proyectos_municipios` (
  `id_proyecto_pk_fk` INT(11) NOT NULL,
  `id_municipio_pk_fk` INT(11) NOT NULL,
  PRIMARY KEY (`id_proyecto_pk_fk`, `id_municipio_pk_fk`),
  INDEX `fk_PROYECTOS_has_MUNICIPIOS_MUNICIPIOS1_idx` (`id_municipio_pk_fk` ASC) ,
  INDEX `fk_PROYECTOS_has_MUNICIPIOS_PROYECTOS1_idx` (`id_proyecto_pk_fk` ASC) ,
  CONSTRAINT `fk_proyectos_municipios_municipios1`
    FOREIGN KEY (`id_municipio_pk_fk`)
    REFERENCES `bd_prod`.`municipios` (`id_municipio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proyectos_municipios_proyectos1`
    FOREIGN KEY (`id_proyecto_pk_fk`)
    REFERENCES `bd_prod`.`proyectos` (`id_proyecto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`proyectos_subregiones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`proyectos_subregiones` (
  `id_proyecto_pk_fk` INT(11) NOT NULL,
  `id_subregion_pk_fk` INT(11) NOT NULL,
  PRIMARY KEY (`id_proyecto_pk_fk`, `id_subregion_pk_fk`),
  INDEX `fk_PROYECTOS_has_SUBREGIONES_SUBREGIONES1_idx` (`id_subregion_pk_fk` ASC) ,
  INDEX `fk_PROYECTOS_has_SUBREGIONES_PROYECTOS1_idx` (`id_proyecto_pk_fk` ASC) ,
  CONSTRAINT `fk_proyectos_subregiones_proyectos1`
    FOREIGN KEY (`id_proyecto_pk_fk`)
    REFERENCES `bd_prod`.`proyectos` (`id_proyecto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proyectos_subregiones_subregiones1`
    FOREIGN KEY (`id_subregion_pk_fk`)
    REFERENCES `bd_prod`.`subregiones` (`id_subregion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`reseñas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`reseñas` (
  `id_reseña` INT(11) NOT NULL AUTO_INCREMENT,
  `id_granja_pk_fk` INT(11) NOT NULL,
  `usuarios_id` INT(11) NOT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  `fecha` DATE NOT NULL,
  `calificacion` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_reseña`, `id_granja_pk_fk`, `usuarios_id`),
  UNIQUE INDEX `unq_user_granja` (`id_granja_pk_fk` ASC, `usuarios_id` ASC) ,
  INDEX `fk_reseñas_usuarios1` (`usuarios_id` ASC) ,
  CONSTRAINT `fk_reseñas_granjas1`
    FOREIGN KEY (`id_granja_pk_fk`)
    REFERENCES `bd_prod`.`granjas` (`id_granja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reseñas_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `bd_prod`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`sender_solicitud`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`sender_solicitud` (
  `id_sender_solicitud` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_sender_solicitud`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`sliders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`sliders` (
  `id_slid` INT(11) NOT NULL AUTO_INCREMENT,
  `url_imagen` TEXT NULL DEFAULT NULL,
  `url_enlace` TEXT NULL DEFAULT NULL,
  `titulo` VARCHAR(45) NULL DEFAULT NULL,
  `mostrar_titulo` TINYINT(4) NULL DEFAULT 0,
  `url_imagen_movil` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_slid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`solicitudes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`solicitudes` (
  `id_solicitud` INT(11) NOT NULL AUTO_INCREMENT,
  `id_estado_fk` INT(11) NOT NULL,
  `usuarios_id_creador` INT(11) NOT NULL,
  `usuarios_id` INT(11) NOT NULL,
  `id_sender_solicitud` INT(11) NOT NULL,
  `nit_asociacion_fk` BIGINT(20) NOT NULL,
  `fecha` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_solicitud`),
  UNIQUE INDEX `usuario_id_asociacion_nit_idx` (`usuarios_id` ASC, `nit_asociacion_fk` ASC) ,
  INDEX `fk_SOLICITUDES_ESTADOS` (`id_estado_fk` ASC) ,
  INDEX `fk_SOLICITUDES_USUARIOS` (`usuarios_id_creador` ASC) ,
  INDEX `fk_SOLICITUDES_USER_ASOCIADOS` (`usuarios_id` ASC) ,
  INDEX `fk_SOLICITUDES_ASOCIACIONES` (`nit_asociacion_fk` ASC) ,
  INDEX `fk_solicitudes_sender_solicitud1_idx` (`id_sender_solicitud` ASC) ,
  CONSTRAINT `fk_solicitudes_asociaciones1`
    FOREIGN KEY (`nit_asociacion_fk`)
    REFERENCES `bd_prod`.`asociaciones` (`nit`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_solicitudes_estados_solicitudes1`
    FOREIGN KEY (`id_estado_fk`)
    REFERENCES `bd_prod`.`estados_solicitudes` (`id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_solicitudes_sender_solicitud1`
    FOREIGN KEY (`id_sender_solicitud`)
    REFERENCES `bd_prod`.`sender_solicitud` (`id_sender_solicitud`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_solicitudes_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `bd_prod`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_solicitudes_usuarios_creador1`
    FOREIGN KEY (`usuarios_id_creador`)
    REFERENCES `bd_prod`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`tiempoSlider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`tiempoSlider` (
  `id` INT(11) NOT NULL,
  `tiempo` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`top_alert`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`top_alert` (
  `id` INT(11) NOT NULL,
  `texto` TEXT NULL DEFAULT NULL,
  `status` TINYINT(4) NULL DEFAULT 0,
  `color` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`usuarios_granjas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`usuarios_granjas` (
  `id_granja_pk_fk` INT(11) NOT NULL,
  `usuarios_id` INT(11) NOT NULL,
  `esfavorita` INT(11) NULL DEFAULT NULL,
  `espropietario` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_granja_pk_fk`, `usuarios_id`),
  INDEX `fk_USUARIOS_has_GRANJAS_GRANJAS1_idx` (`id_granja_pk_fk` ASC) ,
  INDEX `fk_usuarios_granjas_usuarios1_idx` (`usuarios_id` ASC) ,
  CONSTRAINT `fk_usuarios_granjas_granjas1`
    FOREIGN KEY (`id_granja_pk_fk`)
    REFERENCES `bd_prod`.`granjas` (`id_granja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_granjas_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `bd_prod`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `bd_prod`.`usuarios_grupos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_prod`.`usuarios_grupos` (
  `usuarios_id` INT(11) NOT NULL,
  `grupos_id` INT(11) NOT NULL,
  PRIMARY KEY (`usuarios_id`, `grupos_id`),
  INDEX `fk_usuarios_chats_usuarios1_idx` (`usuarios_id` ASC) ,
  INDEX `fk_usuarios_chats_grupos1_idx` (`grupos_id` ASC) ,
  CONSTRAINT `fk_usuarios_grupos_grupos1`
    FOREIGN KEY (`grupos_id`)
    REFERENCES `bd_prod`.`grupos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_grupos_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `bd_prod`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
