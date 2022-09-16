CALL altaRestaurant (1, 'petito37@gordo', 'juncal tu mama', 'petito38', 'momo');
 
CALL altaPlato (1, 'que', 'almomo', 2, 1, TRUE);
CALL altaPlato (2, 'nuevo', 'buenplato', 100, 1, TRUE);
 
CALL registrarCliente (1, 'alberto', 'a', 'elbostero69@', 'kieeee');
 
CALL altaPedido (1, '1999-11-11 00:00:00', 1, 1, 27, 10, 'malardo');
CALL altaPedido (2, '2000-12-12 12:00:00', 1, 1, 50, 8, 'buenplato');
 
CALL altaMenuplato (28, 2, 1, 1);
CALL altaMenuplato (5, 100, 2, 1);
 
 
SELECT gananciaResto (1,'1999-11-11 00:00:00','1999-11-11 00:00:02');
 
 
CALL Buscar('almomo');
