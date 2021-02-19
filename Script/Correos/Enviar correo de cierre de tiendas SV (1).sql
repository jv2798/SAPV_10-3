

--enviar correo de cierre pendientes de tiendas de El Salvador
--se debe conectar al servidor 10.1.1.201\sapvslv
--a la tabla BDWork
--EXEC BDWork.dbo.STPR_ENVIA_ESTADO_CIERRES_COC @MAIL_Destinatario = 'NotificacionCierresSV@grupom.net; Kathy Solera Vargas <kathy.solera@grupomonge.com>; Francisco Antonio Mozo Argueta <francisco.mozo@grupomonge.com>; josue.rosales@grupomonge.com; Hector Menjivar - SV <hector.menjivar@grupomonge.com>',@MAIL_Copia='Centrodatos <Centrodatos@Grupomonge.com>; Oscar Garcia Arguedas <oscar.garcia@grupomonge.com>'


EXEC BDWork.dbo.STPR_ENVIA_ESTADO_CIERRES_COC
