import App from './App'

// #ifndef VUE3
import Vue from 'vue'
// main.js
import uView from '@/uni_modules/uview-ui'
import store from "./store"
Vue.prototype.$store = store
Vue.use(uView)
import request from '@/utils/request.js'
import './uni.promisify.adaptor'
Vue.config.productionTip = false
Vue.prototype.$request = request

App.mpType = 'app'
const app = new Vue({
	...App
})
app.$mount()
// #endif

// #ifdef VUE3
import {
	createSSRApp
} from 'vue'
import {
	createStore
} from './store'

export function createApp() {
	const app = createSSRApp(App)
	return {
		app
	}
}
// #endif