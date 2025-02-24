const getters = {
	statusBarHeight:state=>state.system.statusBarHeight,
	titleBarHeight: state=>state.system.titleBarHeight,
	bodyBarHeight:state=>{
		if(state.system.foldstate) return state.system.titleBarHeight;
		return 100;
		},
		totalHeight: state=>{
			if(state.system.foldstate){
				return state.system.statusBarHeight+state.system.titleBarHeight+10
			}
			return state.system.statusBarHeight+state.system.titleBarHeight+100+10
		},
	foldstate: state=>state.system.foldstate,
	carsList:state=>state.cars.carsList,
	totalPrice: state => {
	  return state.cars.carsList.reduce((total, dish) => {
	    const quantity = Number(dish.numvalue) || 0; // 获取菜品数量
	    const price = Number(dish.price) || 0; // 获取菜品单价
	    const dishTotalPrice = quantity * price; // 计算单个菜品的总价
	    console.log(`dish: ${dish.dishName}, quantity: ${quantity}, price: ${price}, total: ${dishTotalPrice}`);
	    return total + dishTotalPrice; // 累加计算总价
	  }, 0);
	},
	buyNum:state=>{
		return state.cars.carsList.reduce((prev,next)=>{
			const numvalue = Number(next.numvalue) || 0;
			
			return prev+=numvalue
		},0)
	}

}
export default getters;
