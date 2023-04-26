import Vue from 'vue'
import VueRouter from 'vue-router'

/**
 * 重写路由的push方法、replace方法,防止报错
 */
const routerPush = VueRouter.prototype.push
VueRouter.prototype.push = function push(location) {
  return routerPush.call(this, location).catch(error=> error)
}
const originalReplace = VueRouter.prototype.replace;
VueRouter.prototype.replace = function replace(location) {
  return originalReplace.call(this, location).catch(err => err);
};

const Login = () => import('views/login/Login')
const Reg = () => import('../views/reg/Reg.vue')
const Home = () => import('views/home/Home')

const Welcome = () => import('views/home/children/Welcome')
const UserList = () => import('views/home/children/users/UserList')
const AdminList = () => import('views/home/children/users/AdminList')
const CourierList = () => import('views/home/children/users/CourierList')
const TxList = () => import('views/home/children/users/TxList')
const NoticeList = () => import('views/home/children/notice/NoticeList')
const AdviceList = () => import('views/home/children/advice/AdviceList')
const VideoList = () => import('views/home/children/video/VideoList')
const Statistics = () => import('views/home/children/statistics/Statistics')
const ShopStatistics = () => import('views/home/children/statistics/ShopStatistics')
const DicList = () => import('views/home/children/dic/DicList')
const DicItemList = () => import('views/home/children/dic/DicItemList')
const GoodsList = () => import('views/home/children/shop/GoodsList')
const OrderList = () => import('views/home/children/shop/OrderList')
Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    redirect: '/login'
  },
  {
    path: '/login',
    component: Login,
	
  },
  {
    path: '/reg',
    component: Reg,	
  },
  {
    path: '/home',
    component: Home,
    redirect: '/welcome',
    children: [
      {
        path: '/welcome',
        component: Welcome
      },
      {
        path: '/users',
        component: UserList
      },
	  {
	    path: '/admins',
	    component: AdminList
	  },
	  {
	    path: '/courier',
	    component: CourierList
	  },
	  {
	    path: '/tx',
	    component: TxList
	  },
      {
        path: '/notice',
        component: NoticeList
      },
      {
        path: '/advice',
        component: AdviceList
      },
      {
        path: '/video',
        component: VideoList
      },
	  {
	    path: '/statistics',
	    component: Statistics
	  },
    {
	    path: '/dic',
	    component: DicList
	  },  {
	    path: '/dicitem',
	    component: DicItemList
	  },
    {
	    path: '/goods',
	    component: GoodsList
	  },
    {
	    path: '/order',
	    component: OrderList
	  },
    {
	    path: '/shopstatistics',
	    component: ShopStatistics
	  },
    ]
  }
]
const router = new VueRouter({
    routes
})

// 是否已经登录  导航守卫
// router.beforeEach((to, from, next) => {
//   if(to.path === '/login'){
//     return next()
//   }
//   // 获取到token (有无token判断，是否登录)
//   const tokenStr = window.sessionStorage.getItem('token')
//   if(!tokenStr){
//     return next('/login')
//   }else{
//     return next()
//   }
// })

export default router
