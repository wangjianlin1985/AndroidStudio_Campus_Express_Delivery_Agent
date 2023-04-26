<template>
  <div>
    <!-- 导航 -->
    <mbx-nav one-nav="订单管理" two-nav="订单列表"></mbx-nav>
    <!-- 卡片试图 -->
    <el-card>
      <!-- 操作 区域 -->
      <el-row :gutter="2">
        <el-col :span="6">
          <el-select v-model="queryInfo.status" placeholder="请选择类型" clearable  @change="getList">
            <el-option
                v-for="item in dicList"
                :key="item.dm"
                :label="item.dmmc"
                :value="item.dm">
              </el-option>
			    </el-select>
        </el-col>
     
      <!-- <el-col :span="6">
          <el-input placeholder="请输入关键词" v-model="queryInfo.key" clearable @clear="getList()">
            <el-button slot="append" icon="el-icon-search" @click="getList"></el-button>
          </el-input>
        </el-col>      --> 
       
       
      </el-row>
      <!-- 用户列表表格 区域 -->
      <el-table :data="dataList" stripe border class="user-table">
      <el-table-column type="index" label="#"></el-table-column>
	
     <el-table-column prop="id" label="订单编号"></el-table-column>	
	 <el-table-column prop="user.nickname" label="用户昵称"></el-table-column>
	 <el-table-column prop="idnumber" label="取件码"></el-table-column> 
     <el-table-column prop="money" label="打赏金额"></el-table-column>		    
     <el-table-column prop="sendtime" label="送货时间"></el-table-column>	
     <el-table-column prop="phone" label="收货人电话"></el-table-column>		
     <el-table-column prop="address" label="收货人地址"></el-table-column>	    
     
    
     <el-table-column prop="status" label="状态">
      <template v-slot="scope">      
            <el-tag type="success" size="danger" v-if="scope.row.status==0">待接单</el-tag>
            <el-tag type="danger" size="primary" v-else-if="scope.row.status==1">已接单</el-tag>     
            <el-tag type="danger" size="success" v-else-if="scope.row.status==2">已取消</el-tag>
			  <el-tag type="danger" size="success" v-else-if="scope.row.status==3">派送中</el-tag>
			    <el-tag type="danger" size="success" v-else-if="scope.row.status==4">已完成</el-tag>
		  </template>	
     </el-table-column>
		 <el-table-column prop="courier.nickname" label="快递员姓名"></el-table-column>
		<el-table-column prop="courier.phone" label="快递员电话"></el-table-column>	
		 <el-table-column prop="ctime" label="发布时间"></el-table-column>
   
      <el-table-column label="操作">
          <template v-slot="scope">
          <!--  <el-button size="mini" type="primary"   v-if="scope.row.status==0" @click="changeInfo(scope.row)">发货</el-button>	 -->
			     <el-button size="mini" type="danger"  @click="delClick(scope.row)">删除</el-button>     
          </template>
        </el-table-column>
      </el-table>
      <!-- 分页器 -->
      <el-pagination
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page="queryInfo.page"
        :page-sizes="[5, 10, 15, 20]"
        :page-size="queryInfo.limit"
        layout="total, sizes, prev, pager, next, jumper"
        :total="total">
      </el-pagination>
    </el-card>
    
 
  
  </div>
</template>

<script>
import mbxNav from 'components/MbxNav'

import { 
  getList, 
  addInfo,
  postUpload,
  getInfo,
  upInfo,
  delInfo,
  } from 'network/orders'
  import { 
  getItemList,  
  } from 'network/dic'
import {baseUrl} from 'network/global'
export default {
  name: 'NoticeList',
  components: {
    mbxNav
  },
  data(){
    
    return {
    dataList: [],
    dicList:[],
	  imageUrl: '',
    addType:'',
    changeType:'',
    queryDicInfo: {
       did: '1',	   
       page: 1,
       limit: 100
     }, 
     
     queryInfo: {
       status: '',
	   type: '',      
       page: 1,
       limit: 10
     },    
      // 全部用户个数
      total: 0,
      // 添加用户对话框 显示隐藏
      addInfoShow: false,
      // 添加用户数据
      addForm: {
      name:'',
		   img:''
      },
      // 修改用户对话框 显示隐藏
      changeUserShow: false,
      //修改用户数据
      changeForm: {
		 
	  },
	  
     // 添加用户表单验证规则
     rules: {
      name: [
          {required: true, message: '请输入名称', trigger: 'blur'},       
        ],
        dec: [
          {required: true, message: '请输入描述', trigger: 'blur'},
         
        ],
        cid: [
          {required: true, message: '请选择类别', trigger: 'blur'},
         
        ],
        img: [
          {required: true, message: '请上传图片', trigger: 'blur'},
         
        ],
        price: [
          {required: true, message: '请输入价格', trigger: 'blur'},
         
        ],
        num: [
          {required: true, message: '请输入库存', trigger: 'blur'},
         
        ]
      },   
   
    }
  },
  created(){
    this.getList()    
    this.getDicList()
    this.addForm.sid = window.sessionStorage.getItem('token')
	  
 
  },
  methods: {
    /**
     * 获取、更新用户数据
     */
	getImgUrl(url){	

	      return  baseUrl()+"/"+url
	    },
 
 
    getList(){		
      getList(this.queryInfo).then((res) => {
       
       if(res.data.code == 200){
         //获取成功了
          console.log(res.data.data)
         this.dataList = res.data.data.list
         this.total = res.data.data.total
        }
      }).catch((err) => {
        // console.log(err)
      })
    },	
    getDicList(){
       getItemList(this.queryDicInfo).then((res) => {
        
        if(res.data.code == 200){
          //获取成功了
           console.log(res.data.data)
          this.dicList = res.data.data.list       
         }
       }).catch((err) => {
         // console.log(err)
       })
     },	
    
    /**
     * 分页处理
     */
    // 监听 每页条数 pagesize 变化
    handleSizeChange(value){
      // console.log(value)
      this.queryInfo.limit = value
      this.getList()()
    },
    //监听 当前页 pagenum 发生改变
    handleCurrentChange(value){
      // console.log(value)
      this.queryInfo.page = value
      this.getList()
    },

  
   
    //点击修改用户信息  显示修改用户对话框
    changeInfo(info){
      this.changeUserShow = true
      this.changeForm=info
      this.changeForm.status=1
      this.changeClick()
    },
    /**
     * 修改用户请求模块
     */
    changeClick(){     
          /**
           * 修改请求
           */
   
         
      // 确认删除吗消息框？
		  this.$confirm('您确定要发货吗？', '发货' ,{
		    confirmButtonText: '确定',
		    cancelButtonText: '取消',
		    type: 'warning'
		  }).then(() => {
		    /**
		     * 删除请求模块
		     */
         upInfo(this.changeForm).then((res) => {
            // console.log(res)
            if(res.data.code === 200){
              this.changeUserShow = false
              this.$message.success(res.data.msg)
              this.changeForm={}           
              this.getList()
              return 
            }            
          })
		    
		    
		  }).catch(() => {
		    this.$message('已取消')
		  })
         
     
    },

    /**
     * 删除用户模块
     */
    // 
    delClick(userInfo){
    
		  // 确认删除吗消息框？
		  this.$confirm('您确定要永久删除吗？', '永久删除' ,{
		    confirmButtonText: '确定',
		    cancelButtonText: '取消',
		    type: 'warning'
		  }).then(() => {
		    /**
		     * 删除请求模块
		     */
		    delInfo(userInfo.id).then((res) => {
		      if(res.data.code === 200){
		        this.$message.success('删除成功')
		        this.getList()
		        return 
		      }
		      this.$message.success('删除失败，请稍后重试')
		    })
		  }).catch(() => {
		    this.$message('已取消')
		  })
	
     
    },   
	allotClose(){
	  this.selValue = ''
	},
   
 }
}
</script>

<style lang="less" scoped>
  .user-table{
    margin-top: 20px;
    font-size: 12px;
  }
  .el-pagination{
    margin-top: 20px;
  }
  .text{
    padding:5px 0;
  }
  .text-sel{
    padding-top: 10px;
  }
  
  .avatar-uploader .el-upload {
      border: 1px dashed #d9d9d9;
      border-radius: 6px;
      cursor: pointer;
      position: relative;
      overflow: hidden;
    }
    .avatar-uploader .el-upload:hover {
      border-color: #409EFF;
    }
    .avatar-uploader-icon {
      font-size: 28px;
      color: #8c939d;
      width: 178px;
      height: 178px;
      line-height: 178px;
      text-align: center;
    }
    .avatar {
      width: 128px;
      height: 128px;
      display: block;
    }
	.el-avatar{
		width: 80px;
		height: 80px;
		display: block;
	}
</style>