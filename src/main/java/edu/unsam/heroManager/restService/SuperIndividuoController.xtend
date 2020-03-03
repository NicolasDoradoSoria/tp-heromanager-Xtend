package edu.unsam.heroManager.restService

import com.fasterxml.jackson.annotation.JsonAutoDetect
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility
import com.google.gson.Gson
import edu.unsam.heroManager.Compra
import edu.unsam.heroManager.RepoSuperIndividuo
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import edu.unsam.heroManager.RepoItem

@Controller
@JsonAutoDetect(fieldVisibility = Visibility.ANY)

class SuperIndividuoController {
		RepoSuperIndividuo repoSuperIndividuo = RepoSuperIndividuo.getInstance
		RepoItem repoItem = RepoItem.getInstance
		val Gson gson = new Gson()

	
	@Get("/compras/individuo/:id")
	def Result compras(@Body String body) {
		try {
			val superIndividuo = repoSuperIndividuo.searchById(id)
			val ultimasCompras = superIndividuo.comprasUltimaSemana.reverse
			val ultimasComprasString = ComprasSerializer.toJson(ultimasCompras)
			ok(ultimasComprasString) 
		} catch (Exception e) {
			internalServerError('{ "status" : "'+e.message +'" }')
		}
	} 
	
	@Get("/obtener_items/:id")
	def Result todosLosItems() {
		try {
			val superIndividuo = repoSuperIndividuo.searchById(id)
			ok(ItemSerializer.toJson(superIndividuo.getItems)) 
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}
	
	@Post ("/compraritem/individuo/:id")
	def Result compraItem(@Body String body) {
		try {
			val compra = gson.fromJson(body,Compra)
			repoItem.descontarStock(compra.item,compra.cantidad)
			repoSuperIndividuo.agregarCompra(compra,id)
			ok('{ "status" : "Compra realizada con exito" }')
		} catch (Exception e) {
			internalServerError('{ "status" : "'+e.message +'" }')
		}
	}
	
}