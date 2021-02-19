--enviar correo de cierre pendientes de tiendas de Honduras
--se debe conectar al servidor 10.1.1.64
--a la tabla BDWork
 EXEC BDWork.dbo.STPR_ENVIA_ESTADO_CIERRES_COC
--EXEC BDWork.dbo.STPR_ENVIA_ESTADO_CIERRES_COC @MAIL_Destinatario = 'idocs@grupom.com.hn; Kathy Solera Vargas <kathy.solera@grupomonge.com>; Jairo Lenyn Medrano Martinez <jairo.medrano@grupomonge.com>',@MAIL_Copia='Centrodatos <Centrodatos@Grupomonge.com>; Oscar Garcia Arguedas <oscar.garcia@grupomonge.com>' 

