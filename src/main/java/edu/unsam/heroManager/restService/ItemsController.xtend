package edu.unsam.heroManager.restService

import com.fasterxml.jackson.annotation.JsonAutoDetect
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility
import edu.unsam.heroManager.RepoItem
import edu.unsam.heroManager.RepoSuperIndividuo
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils

@Controller
@JsonAutoDetect(fieldVisibility = Visibility.ANY)
class ItemsController {
	extension JSONUtils = new JSONUtils
	RepoItem repoItem = RepoItem.getInstance

	
	@Get("/items_en_venta")
	def Result todosLosItems() {
		try {
			val itemsEnVenta = repoItem.itemsEnVenta
			ok(ItemSerializer.toJson(itemsEnVenta)) 
		} catch (Exception e) {
		 internalServerError('{ "status" : "'+e.message +'" }')
		}
	}
	
	@Get("/obtener_item_completo/:id")
	def Result unItemCompleto() {
		try {
			val item = repoItem.searchById(id)
			ok(item.toJson) 
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}
	

	
}
