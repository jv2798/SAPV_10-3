--enviar correo de cierre pendientes de tiendas de Nicaragua
--se debe conectar al servidor 10.1.1.110\sapvnic
--a la tabla BDWork
 EXEC BDWork.dbo.STPR_ENVIA_ESTADO_CIERRES_COC
--EXEC BDWork.dbo.STPR_ENVIA_ESTADO_CIERRES_COC @MAIL_Destinatario = 'NotificacionCierresNI@grupom.net; Slilmalila Jacoby Perez Alvarado - NI <slilmalila.perez@grupomonge.com>;Glenda Pamela Espinoza Vega <glenda.espinoza@grupomonge.com>; Kathy Solera Vargas <kathy.solera@grupomonge.com>',@MAIL_Copia='Centrodatos <Centrodatos@Grupomonge.com>; Oscar Garcia Arguedas <oscar.garcia@grupomonge.com>' 
 


