import { request } from './request'

//获取列表数据
export function getList(data){
  return request({
    url: '/dic/queryPage',
	data: data,
     method: 'post',
	 transformRequest: [function (data) {  // 将{username:111,password:111} 转成 username=111&password=111
	                     var ret = '';
	                     for (var it in data) {
	                         // 如果要发送中文 编码
	                         ret += encodeURIComponent(it) + '=' + encodeURIComponent(data[it]) + '&'
	                     }
	                     return ret.substring(0,ret.length-1)
	                 }]
  })
}



//添加
export function addInfo(data){
  return request({
    url: '/dic/addInfo',
    method: 'post',
    data: data,
   
  })
}

// 根据id查询
export function getInfo(id){
  return request({
    url: '/dic/getInfo' ,
	method: 'post',
    data: {id},
 	transformRequest: [function (data) {  // 将{username:111,password:111} 转成 username=111&password=111
 		                    var ret = '';
 		                    for (var it in data) {
 		                        // 如果要发送中文 编码
 		                        ret += encodeURIComponent(it) + '=' + encodeURIComponent(data[it]) + '&'
 		                    }
 		                    return ret.substring(0,ret.length-1)
 		                }]
 	})
}



// 修改
export function upInfo(data){
  return request({
    url: '/dic/upInfo' ,
    method: 'post',
    data: data,	
	
 }) 
}

//删除
export function delInfo(id){
  return request({
    url: '/dic/delInfo',
    method: 'post',
	data:{id},
	transformRequest: [function (data) {  // 将{username:111,password:111} 转成 username=111&password=111
		                    var ret = '';
		                    for (var it in data) {
		                        // 如果要发送中文 编码
		                        ret += encodeURIComponent(it) + '=' + encodeURIComponent(data[it]) + '&'
		                    }
		                    return ret.substring(0,ret.length-1)
		                }]
	
  })
}



//获取
export function getItemList(data){
	return request({
	  url: '/dic/queryPageItem',
	  data: data,
	   method: 'post',
	   transformRequest: [function (data) {  // 将{username:111,password:111} 转成 username=111&password=111
						   var ret = '';
						   for (var it in data) {
							   // 如果要发送中文 编码
							   ret += encodeURIComponent(it) + '=' + encodeURIComponent(data[it]) + '&'
						   }
						   return ret.substring(0,ret.length-1)
					   }]
	})
  }
  
  
  
  //添加用户
  export function addItemInfo(data){
	return request({
	  url: '/dic/addItemInfo',
	  method: 'post',
	  data: data,
	 
	})
  }

  
  
  
  // 修改用户信息
  export function upItemInfo(data){
	return request({
	  url: '/dic/upItemInfo' ,
	  method: 'post',
	  data: data,	
	  
   }) 
  }
  
  //删除用户
  export function delItemInfo(id){
	return request({
	  url: '/dic/delItemInfo',
	  method: 'post',
	  data:{id},
	  transformRequest: [function (data) {  // 将{username:111,password:111} 转成 username=111&password=111
							  var ret = '';
							  for (var it in data) {
								  // 如果要发送中文 编码
								  ret += encodeURIComponent(it) + '=' + encodeURIComponent(data[it]) + '&'
							  }
							  return ret.substring(0,ret.length-1)
						  }]
	  
	})
  }