<template>
  <div>
    <!-- 导航 -->
    <mbx-nav one-nav="培训资源" two-nav="视频列表"></mbx-nav>
    <!-- 卡片试图 -->
    <el-card>
      <!-- 操作 区域 -->
      <el-row :gutter="2">
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
          <el-input placeholder="请输入关键词" v-model="queryInfo.key" clearable @clear="getList()">
            <el-button slot="append" icon="el-icon-search" @click="getList"></el-button>
          </el-input>
        </el-col>
        
        <el-col :span="6">
          <el-button type="primary" @click="addInfo">添加</el-button>
        </el-col>
       
      </el-row>
      <!-- 用户列表表格 区域 -->
      <el-table :data="dataList" stripe border class="user-table">
        <el-table-column type="index" label="#"></el-table-column>
		<el-table-column label="视频缩略图" prop="img">		 
		  <template v-slot="scope">
       
   <!--trigger属性值：hover、click、focus 和 manual-->
    <a :href="getImgUrl(scope.row.img)"  target="_blank" title="查看最大化图片">
   <img :src="getImgUrl(scope.row.img)" style="width: 100px;height: 100px">
   </a>
   		
		  </template>
		  </el-table-column>
        <el-table-column prop="title" label="标题"></el-table-column>
		<el-table-column prop="dec" label="描述"></el-table-column>		
		 <el-table-column prop="lxmc" label="类别">	 </el-table-column> 
		
		 <el-table-column prop="ctime" label="创建时间"></el-table-column>
   
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
        <el-form-item label="标题" prop='title'>
          <el-input v-model="addForm.title"></el-input>
        </el-form-item>
		  <el-form-item label="视频缩略图" prop="img">
		   <el-upload
		     class="avatar-uploader"
		     action="http://localhost:81/upload/"
		     :show-file-list="false"
		     :on-success="addAvatarSuccess"
		     :before-upload="beforeAvatarUpload">
		     <img v-if="addForm.img" :src="getImgUrl(addForm.img)" class="avatar">
		     <i v-else class="el-icon-plus avatar-uploader-icon"></i>
		   </el-upload>
		  </el-form-item>
       
        <el-form-item  label="视频上传：" prop="tempVideoFile">
          <el-upload
            class="avatar-uploader el-upload--text"
            action="http://localhost:81/upload/"
            :auto-upload="false"
            :show-file-list="false"
            :on-change="uploadAdd"           
            accept=".mp4,.ogg,.flv,.avi,wmv,.rmvb"
          >
            <video
              v-if="addForm.tempVideoFile"
              :src="addForm.tempVideoFile"
              class="avatar"
              controls="controls"
            >您的浏览器不支持视频播放
            </video>
            <p v-if="addForm.tempVideoFile" class="videoName">{{ addForm.videoFile && addForm.videoFile.name }}</p>
            <span v-else-if="!addForm.tempVideoFile" class="chooseVideo">点击上传</span>
          </el-upload>
          <P class="text">请保证视频格式正确，且不超过50M</P>
        </el-form-item>
		<el-form-item label="类别" prop='lxdm' >
      <el-select v-model="addType"  @change="addTypeChange($event)" placeholder="请选择类型">
            <el-option
                v-for="item in dicList"
                :key="item.id"
                :label="item.dmmc"
                :value="item">
              </el-option>
			    </el-select>
			
		</el-form-item>
        <el-form-item label="描述" prop='dec'>
          <el-input v-model.trim="addForm.dec"
                           type="textarea"
                           resize="none"
                           :rows="3"                           
                           :maxlength="500"
                            />
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
        <el-form-item label="标题" prop='title'>
            <el-input v-model="changeForm.title"></el-input>
         </el-form-item>
		  <el-form-item label="视频缩略图片" prop="img">
		   <el-upload
		     class="avatar-uploader"
		     action="http://localhost:81/upload/"
		     :show-file-list="false"
		     :on-success="changeAvatarSuccess"
		     :before-upload="beforeAvatarUpload">
		     <img v-if="changeForm.img" :src="getImgUrl(changeForm.img)" class="avatar">
		     <i v-else class="el-icon-plus avatar-uploader-icon"></i>
		   </el-upload>
		  </el-form-item>
		
         <el-form-item  label="视频上传：" prop="tempVideoFile">
          <el-upload
            class="avatar-uploader el-upload--text"
            action="http://localhost:81/upload/"
            :auto-upload="false"
            :show-file-list="false"
            :on-change="uploadChange"           
            accept=".mp4,.ogg,.flv,.avi,wmv,.rmvb"
          >
            <video
              v-if="changeForm.tempVideoFile"
              :src="changeForm.tempVideoFile"
              class="avatar"
              controls="controls"
            >您的浏览器不支持视频播放
            </video>
            <p v-if="changeForm.tempVideoFile" class="videoName">{{ changeForm.videoFile && changeForm.videoFile.name }}</p>
            <span v-else-if="!changeForm.tempVideoFile" class="chooseVideo">点击上传</span>
          </el-upload>
          <P class="text">请保证视频格式正确，且不超过50M</P>
        </el-form-item>
		<el-form-item label="类别" prop='lxdm' >
      <el-select v-model="changeType"  @change="upTypeChange($event)" placeholder="请选择类型">
            <el-option
                v-for="item in dicList"
                :key="item.id"
                :label="item.dmmc"
                :value="item">
              </el-option>
			    </el-select>
			
		</el-form-item>
        <el-form-item label="描述" prop='dec'>
          <el-input v-model.trim="changeForm.dec"
                           type="textarea"
                           resize="none"
                           :rows="3"                           
                           :maxlength="500"
                            />
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
  getList, 
  addInfo,
  postUpload,
  getInfo,
  upInfo,
  delInfo,
  } from 'network/video'
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
       did: '4',	   
       page: 1,
       limit: 100
     }, 
     
     queryInfo: {
       key: '',
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
      title:'',
		   img:''
      },
      // 修改用户对话框 显示隐藏
      changeUserShow: false,
      //修改用户数据
      changeForm: {
		 
	  },
	  
     // 添加用户表单验证规则
     rules: {
      title: [
          {required: true, message: '请输入标题', trigger: 'blur'},       
        ],
        content: [
          {required: true, message: '请输入内容', trigger: 'blur'},
         
        ],
        type: [
          {required: true, message: '请选择类别', trigger: 'blur'},
         
        ],
        img: [
          {required: true, message: '请上传图片', trigger: 'blur'},
         
        ],
        video: [
          {required: true, message: '请上传视频', trigger: 'blur'},
         
        ]
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
  addTypeChange(e){
    console.log(e)
        this.addForm.lxdm=e.dm
        this.addForm.lxmc=e.dmmc
        this.addType=e.dmmc
      },
  upTypeChange(e){
    console.log(e)
        this.changeForm.lxdm=e.dm
        this.changeForm.lxmc=e.dmmc
        this.changeType=e.dmmc
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
     changeAvatarSuccess(res, file) {
		  this.imageUrl = URL.createObjectURL(file.raw);
		  if(res.code === 200){
		   //获取成功了
		         this.changeForm.img=res.data;
		  
		  }          
		  
         },
	addAvatarSuccess(res, file) {
		 		  this.imageUrl = URL.createObjectURL(file.raw);
		 		  if(res.code === 200){
		 		   //获取成功了
		 		      this.addForm.img=res.data;
		 		  
		 		  }          
		 		  
		     },
     beforeAvatarUpload(file) {
        
           const isLt2M = file.size / 1024 / 1024 < 2;
   
           
           if (!isLt2M) {
             this.$message.error('上传头像图片大小不能超过 2MB!');
           }
           return  isLt2M;
         },

    // 上传视频
    uploadAdd(file, fileList) {
      const isLt50M = file.size / 1024 / 1024 < 50
      if (['video/mp4', 'video/ogg', 'video/flv', 'video/avi', 'video/wmv', 'video/rmvb'].indexOf(file.raw.type) === -1) {
        this.$message.error('请上传正确的视频格式')
        return false
      }
      if (!isLt50M) {
        this.$message.error('上传视频大小不能超过50MB哦!')
        return false
      }
      let localUrl = null
      if (window.createObjectURL !== undefined) {
        // basic
        localUrl = window.createObjectURL(file.raw)
      } else if (window.URL !== undefined) {
        // mozilla(firefox)
        localUrl = window.URL.createObjectURL(file.raw)
      } else if (window.webkitURL !== undefined) {
        // webkit or chrome
        localUrl = window.webkitURL.createObjectURL(file.raw)
      }
      this.$set(this.addForm, 'tempVideoFile', localUrl)
      this.$set(this.addForm, 'videoFile', file.raw)
      this.$refs.addForm.clearValidate('tempVideoFile')
      console.log('sdadsa:'+localUrl)
      console.log('sdadsa1:'+this.addForm.videoFile)
      postUpload(this.addForm.videoFile).then((res) => {
            console.log(res)
            if(res.data.code === 200){             
              this.$message.success(res.data.msg)   
              this.addForm.video=res.data.data;        
              return
            }
            this.$message.success(res.data.msg) 
          })
    },  
    // 上传视频
    uploadChange(file, fileList) {
      const isLt50M = file.size / 1024 / 1024 < 50
      if (['video/mp4', 'video/ogg', 'video/flv', 'video/avi', 'video/wmv', 'video/rmvb'].indexOf(file.raw.type) === -1) {
        this.$message.error('请上传正确的视频格式')
        return false
      }
      if (!isLt50M) {
        this.$message.error('上传视频大小不能超过50MB哦!')
        return false
      }
      let localUrl = null
      if (window.createObjectURL !== undefined) {
        // basic
        localUrl = window.createObjectURL(file.raw)
      } else if (window.URL !== undefined) {
        // mozilla(firefox)
        localUrl = window.URL.createObjectURL(file.raw)
      } else if (window.webkitURL !== undefined) {
        // webkit or chrome
        localUrl = window.webkitURL.createObjectURL(file.raw)
      }
      this.$set(this.changeForm, 'tempVideoFile', localUrl)
      this.$set(this.changeForm, 'videoFile', file.raw)
      this.$refs.changeForm.clearValidate('tempVideoFile')
      console.log('sdadsa:'+localUrl)
      console.log('sdadsa1:'+this.changeForm.videoFile)
      postUpload(this.changeForm.videoFile).then((res) => {
            console.log(res)
            if(res.data.code === 200){             
              this.$message.success(res.data.msg)   
              this.changeForm.video=res.data.data;        
              return
            }
            this.$message.success(res.data.msg) 
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
      this.$refs.addForm.validate((reg) => {
        if(reg){
          // 验证成功发（请求）
          // 验证成功发（请求）
          addInfo(this.addForm).then((res) => {
            // console.log(res)
            if(res.data.code === 200){
              this.addInfoShow = false
              this.addForm={}
              this.addType=''
              this.$message.success(res.data.msg)
              this.getList()
              return
            }
            this.$message.success(res.data.msg) 
          })
        }
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
     this.$refs.changeForm.validate((reg) => {
        if(reg){
          // 验证成功发（请求）
          // 验证成功发（请求）
          upInfo(this.changeForm).then((res) => {
            // console.log(res)
            if(res.data.code === 200){
              this.changeUserShow = false
              this.$message.success(res.data.msg)
              this.changeForm={}
              this.changeType=''
              this.getList()
              return 
            }
            
          })
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