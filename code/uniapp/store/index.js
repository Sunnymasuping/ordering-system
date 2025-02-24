import Vue from "vue"
import Vuex from "vuex"
import system from "@/store/modules/system.js"
import cars from "@/store/modules/cars.js"
import getters from "./getters"

Vue.use(Vuex)

const store =new Vuex.Store({
	
	getters,
	modules:{
		system,
		cars
	}
})

export default store