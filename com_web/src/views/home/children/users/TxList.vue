<template>
  <div>
    <!-- 导航 -->
    <mbx-nav one-nav="" two-nav="提现记录"></mbx-nav>
    <!-- 卡片试图 -->
    <el-card>
     
      <!-- 用户列表表格 区域 -->
      <el-table :data="dataList" stripe border class="user-table">
        <el-table-column type="index" label="#"></el-table-column>
        <el-table-column prop="uid" label="用户Id"></el-table-column>
    <el-table-column prop="money" label="提现金额"></el-table-column>
		<el-table-column prop="cardnum" label="银行卡号"></el-table-column>		
    <el-table-column prop="name" label="姓名"></el-table-column>		
		 <el-table-column prop="ctime" label="提现时间"></el-table-column>
   
    <!-- <el-table-column label="操作">
          <template v-slot="scope">
          
			<el-button size="mini" type="danger" icon="el-icon-delete"  @click="delClick(scope.row)"></el-button>     
          </template>
        </el-table-column>
		-->
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
  delInfo,
  } from 'network/txrecord'
import {baseUrl} from 'network/global'
export default {
  name: 'AdviceList',
  components: {
    mbxNav
  },
  data(){
    
    return {
      dataList: [],
	 
	
   
     // 订单列表查询参数
     queryInfo: {
       uid: '', 
      
       page: 1,
       limit: 10
     },    
      // 全部用户个数
      total: 0,
   
    
   
    }
  },
  created(){
	this.queryInfo.uid=window.sessionStorage.getItem('uid')
    this.getList()
  },
  methods: {
   

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