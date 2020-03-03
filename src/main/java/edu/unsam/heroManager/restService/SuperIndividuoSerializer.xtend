package edu.unsam.heroManager.restService

import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.SerializerProvider
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import edu.unsam.heroManager.SuperIndividuo
import java.io.IOException
import java.util.List
import edu.unsam.heroManager.Compra

class SuperIndividuoSerializer extends StdSerializer<SuperIndividuo> {

	new(Class<SuperIndividuo> t) {
		super(t);
	}

	override serialize(SuperIndividuo value, JsonGenerator gen, SerializerProvider provider) throws IOException {
		gen.writeStartObject();
		gen.writeStringField("id", value.id);
		gen.writeStringField("apodo", value.apodo);
		gen.writeStringField("email", value.email);
		gen.writeStringField("foto", value.photoUrl);
		gen.writeNumberField("balance",value.dinero)
		gen.writeEndObject();
	}
	
	static def String toJson(SuperIndividuo individuo) {
		mapper().writeValueAsString(individuo)
	}
	
	static def String toJson(List<SuperIndividuo> individuos) {
		if(individuos===null || individuos.empty){return "[ ]"}
		mapper().writeValueAsString(individuos)
	}
	static def mapper(){
		val ObjectMapper mapper = new ObjectMapper()
		val SimpleModule module = new SimpleModule()
		module.addSerializer(SuperIndividuo,new SuperIndividuoSerializer(SuperIndividuo))
		mapper.registerModule(module)
		mapper
	}
}

class ComprasSerializer extends StdSerializer<Compra> {

	new(Class<Compra> t) {
		super(t);
	}

	override serialize(Compra value, JsonGenerator gen, SerializerProvider provider) throws IOException {
		gen.writeStartObject();
		gen.writeStringField("apodo", value.item.nombre);
		gen.writeNumberField("cantidad", value.cantidad);
		gen.writeNumberField("precio", value.precioTotal);
		gen.writeEndObject();
	}
	
	static def String toJson(List<Compra> compras) {
		mapper().writeValueAsString(compras)
	}
	
	static def mapper(){
		val ObjectMapper mapper = new ObjectMapper()
		val SimpleModule module = new SimpleModule()
		module.addSerializer(Compra,new ComprasSerializer(Compra))
		mapper.registerModule(module)
		mapper
	}
}

