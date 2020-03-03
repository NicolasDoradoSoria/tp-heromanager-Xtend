package edu.unsam.heroManager

import com.fasterxml.jackson.annotation.JsonIgnore
import java.time.LocalDate
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Compra {
	@JsonIgnore LocalDate fechaCompra = LocalDate.now
	ItemSimple item
	int cantidad

	def precioTotal() {
		item.precio * cantidad
	}

	def esDeLaUltimaSemana() {
		val fechaTope = LocalDate.now().minusWeeks(1)
		fechaTope.isBefore(fechaCompra)
	}

}
