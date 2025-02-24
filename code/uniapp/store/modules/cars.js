const cars = {
	state: {
		carsList:[
		
		]
	},
	mutations: {
		setcarsList(state,params){
			
			let {dish,num} = params;
			
			let cardish ={
				goodsid:dish.dishId || dish.goodsid,
				numvalue:num,
				dishName:dish.dishName,
				price:dish.price,
				specification:dish.specification,
				picture:dish.picture
			}
			
			let idx = state.carsList.findIndex (car=>{
				return car.goodsid == cardish.goodsid
			})
			
			console.log(idx)
			//解决重复添加进购物车
			if(idx<0){
				state.carsList.unshift(cardish)
			}else{
				state.carsList[idx].numvalue = cardish.numvalue;
				if(state.carsList[idx].numvalue<=0) state.carsList.splice(idx,1)	
			}
		},
		clearCarsList(state) {
		      state.carsList = [];
		    }
	}
}
export default cars