<template>
  <div>
    <!-- 导航 -->
    <mbx-nav one-nav="字典管理" two-nav="字典列表"></mbx-nav>
    <!-- 卡片试图 -->
    <el-card>
      <!-- 操作 区域 -->
      <el-row :gutter="20">
      
        <el-col :span="6">
          <el-select v-model="queryInfo.did" placeholder="请选择类型" clearable  @change="getList">
            <el-option
                v-for="item in dicList"
                :key="item.dm"
                :label="item.dmmc"
                :value="item.dm">
              </el-option>
			    </el-select>
          
        </el-col>       
        <el-col :span="6">
          <el-button type="primary" @click="addInfo">添加</el-button>
        </el-col>
       
      </el-row>
      <!-- 用户列表表格 区域 -->
      <el-table :data="dataList" stripe border class="user-table">
      <el-table-column type="index" label="#"></el-table-column>
		  <el-table-column prop="did" label="字典类型代码"></el-table-column>	
      <el-table-column prop="dm" label="代码"></el-table-column>
		  <el-table-column prop="dmmc" label="代码名称"></el-table-column>		
		
   
        <el-table-column label="操作">
          <template v-slot="scope">
           <el-button size="mini" type="primary" icon="el-icon-edit" @click="changeInfo(scope.row)"></el-button>	
			     <el-button size="mini" type="danger" icon="el-icon-delete"  @click="delClick(scope.row)"></el-button>     
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
    <!-- 添加用户对话框 -->
    <el-dialog
      title="添加"
      :visible.sync="addInfoShow"
      width="50%"
      :before-close="addClose">
      <el-form :rules="rules" ref="addForm" :model="addForm" label-width="70px">
        <el-form-item label="字典类型" prop='title'>
          <el-select v-model="addForm.did" placeholder="请选择类型">
            <el-option
                v-for="item in dicList"
                :key="item.dm"
                :label="item.dmmc"
                :value="item.dm">
              </el-option>
			    </el-select>
        </el-form-item>
        <el-form-item label="代码" prop='title'>
          <el-input  type="number" v-model="addForm.dm"></el-input>
        </el-form-item>
        <el-form-item label="代码名称" prop='title'>
          <el-input v-model="addForm.dmmc"></el-input>
        </el-form-item>	
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="addClose">取 消</el-button>
        <el-button type="primary" @click="addClick">确 定</el-button>
      </span>
    </el-dialog>
    <!-- 修改用户对话框 -->
    <el-dialog
      title="修改"
      :visible.sync="changeUserShow"
      width="50%"
      :before-close="changeClose">
      <el-form :rules="rules" ref="changeForm" :model="changeForm" label-width="70px">
		    <el-form-item label="代码" prop='title'>
          <el-input  type="number" disabled v-model="changeForm.dm"></el-input>
        </el-form-item>
        <el-form-item label="代码名称" prop='title'>
          <el-input v-model="changeForm.dmmc"></el-input>
        </el-form-item>
	
       
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="changeClose">取 消</el-button>
        <el-button type="primary" @click="changeClick">确 定</el-button>
      </span>
    </el-dialog>
 
  
  </div>
</template>

<script>
import mbxNav from 'components/MbxNav'

import { 
  getItemList, 
  addItemInfo,
  getList, 
  upItemInfo,
  delItemInfo, 
  } from 'network/dic'
import {baseUrl} from 'network/global'
export default {
  name: 'DicList',
  components: {
    mbxNav
  },
  data(){
    
    return {
      dataList: [],
      dicList:[],
	    
     
     // 订单列表查询参数
      queryInfo: {
       did: '',	   
       page: 1,
       limit: 10
     },    
      // 全部用户个数
      total: 0,
      // 添加用户对话框 显示隐藏
      addInfoShow: false,
      // 添加用户数据
      addForm: {
        did:'',
       dm:'',
		   dmmc:'',
      
      },
      // 修改用户对话框 显示隐藏
      changeUserShow: false,
      //修改用户数据
      changeForm: {
		 
	  },
	  
      // 添加用户表单验证规则
      rules: {
       
      },   
   
    }
  },
  created(){
    this.getList()
    this.getDicList()
  },
  methods: {
    /**
     * 获取、更新用户数据
     */
	getImgUrl(url){	

	      return  baseUrl()+"/"+url
	    },

    getList(){		
      getItemList(this.queryInfo).then((res) => {
       
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
      this.queryInfo.limit=1000	
      getList(this.queryInfo).then((res) => {
       
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

    /**
     * 添加用户模块
     */
    // 点击添加用户 / 显示用户对话框
    addInfo(){
      this.addInfoShow = true
    },
    //添加用户对话框关闭
    addClose(){   
      this.addInfoShow = false
    },
    /**
     * 添加用户请求模块
     */
    addClick(){     
          // 验证成功发（请求）
          addItemInfo(this.addForm).then((res) => {
            // console.log(res)
            if(res.data.code === 200){
              this.addInfoShow = false
              this.$message.success(res.data.msg)
              this.getList()
              return
            }
            this.$message.success(res.data.msg) 
          })
           
    },

    /**
     * 修改用户信息模块
     */
    // 修改用户对话框关闭
    changeClose(){     
      this.changeUserShow = false
    },
    //点击修改用户信息  显示修改用户对话框
    changeInfo(info){
      this.changeUserShow = true
     
      this.changeForm = info
      
    },
    /**
     * 修改用户请求模块
     */
    changeClick(){     
          /**
           * 修改请求
           */
          upItemInfo(this.changeForm).then((res) => {
            // console.log(res)
            if(res.data.code === 200){
              this.changeUserShow = false
              this.$message.success(res.data.msg)
              this.getList()
              return 
            }
            
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
		    delItemInfo(userInfo.id).then((res) => {
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