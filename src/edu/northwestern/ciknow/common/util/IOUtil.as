package edu.northwestern.ciknow.common.util
{
	
	import edu.northwestern.ciknow.common.domain.QuestionDTO;
	import edu.northwestern.ciknow.common.domain.SharedModel;
	import edu.northwestern.ciknow.common.domain.SurveyDTO;
	
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	public class IOUtil
	{
		private static var logger:ILogger = LogUtil.getLog(IOUtil);
		
		[Inject]
		public var model:SharedModel;
		
		[Inject]
		public var filedownload:FileDownload;
		
		[Inject]
		public var fileupload:FileUpload;

		[Inject]
		public var qu:QuestionUtil;
		
		public function IOUtil()
		{
		}
		
		public function viewCodebook():void{
			flash.net.navigateToURL(new URLRequest(model.baseURL + "/codebook.jsp"));
		}
		
		public function viewNodeAttributesSample():void{
			flash.net.navigateToURL(new URLRequest(model.baseURL + "/html/nodeAttributes.sample.txt"));
		} 
		
		public function downloadMahoutPreferences():void{
			var vars:URLVariables = new URLVariables();
			vars.action = "mahoutPreferences";
			download(vars, "ratings.txt");
		}
		
		public function downloadContacts(t:String):void{
			var vars:URLVariables = new URLVariables();
			vars.action = "getNodes";           	    
			vars.template = t;        
            download(vars, "nodes.txt");			
		}
		
		public function downloadNodeData(groupId:String, questionIds:ArrayCollection, prettyFormat:Boolean):void{
			var vars:URLVariables = new URLVariables();
			vars.action = "downloadNodeData";  
			vars.groupId = groupId;
			vars.questionIds = questionIds;
			vars.prettyFormat = prettyFormat?"1":"0";
			download(vars, "nodeData.txt");			
		}
		
		public function downloadUserGroups():void{
			var vars:URLVariables = new URLVariables();
			vars.action = "getNodeGroups";           	            
            download(vars, "nodeGroups.txt");			
		}
		
		public function downloadUserRoles():void{
			var vars:URLVariables = new URLVariables();
			vars.action = "getNodeRoles";           	            
            download(vars, "nodeRoles.txt");			
		}
										      
		public function downloadSurvey(filenameFormat:String, outputFormat:String, 
									   keepEmptyPrivateGroup:Boolean, 
									   removeNonRespondent:Boolean, 
									   exportByColumn:Boolean):void{
			var survey:SurveyDTO = model.currentSurvey;
			var vars:URLVariables = new URLVariables();
			vars.action = "getSurvey";
            vars.surveyId = survey.surveyId; 
            vars.filenameFormat = filenameFormat;
            vars.outputFormat = outputFormat;
			vars.keepEmptyPrivateGroup = keepEmptyPrivateGroup?"1":"0";
            vars.removeNonRespondent = removeNonRespondent?"1":"0";
			vars.exportByColumn	= exportByColumn?"1":"0";
			
            if (filenameFormat == "name") download(vars, survey.name + ".zip");			
            else download(vars, "ciknow.zip");
		}
						        
		public function downloadQuestion(qid:Number, filenameFormat:String, outputFormat:String, 
										 keepEmptyPrivateGroup:Boolean, 
										 removeNonRespondent:Boolean, 
										 ignoreActivities:Boolean, 
										 exportByColumn:Boolean):void{	            
            var question:QuestionDTO = qu.getQuestionById(model.questions, qid);
			var index:Number = model.questions.getItemIndex(question);
            var vars:URLVariables;
            var fileName:String;
            if (question == null){
            	Alert.show("please specify question to be downloaded.");
            	return;
            } else {
        		vars = new URLVariables();
        		vars.action = "getQuestion";
            	vars.questionId = question.questionId;  
            	vars.filenameFormat = filenameFormat;
            	vars.outputFormat = outputFormat;
            	vars.keepEmptyPrivateGroup = keepEmptyPrivateGroup?"1":"0";
				vars.removeNonRespondent = removeNonRespondent?"1":"0";
				vars.ignoreActivities = ignoreActivities?"1":"0";
				vars.exportByColumn	= exportByColumn?"1":"0";
				
            	if (filenameFormat == "name") fileName = question.shortName + ".txt";
            	else if (filenameFormat == "sequence") fileName = "sn_" + (index + 1) + ".txt";
            	else if (filenameFormat == "id") fileName = "id_" + question.questionId + ".txt";
            	else fileName = "unnamed.txt";
            }
            
            download(vars, fileName);
		}      
        
        public function downloadCodebook():void{
        	var vars:URLVariables = new URLVariables();
        	vars.action = "codebook";
        	download(vars, "ciknow.codebook.xml");
        }              
        
        public function downloadNetwork(row:String, col:String, type:String, source:String):void{
			var vars:URLVariables = new URLVariables();
			vars.action = "getNetwork";     
			vars.row = row;
			vars.col = col;      	            
			vars.type = type;
			vars.source = source;
            download(vars, row + "." + col + "." + type + "." + source + ".txt");	
        }            		

        public function downloadGraphml(importable:Boolean):void{
			var vars:URLVariables = new URLVariables();
			vars.action = "graphml";   
			vars.importable = importable?"1":"0";
            download(vars, "ciknow.graphml.xml");	
        }
        
        public function downloadDL(labelEmbedded:String, showIsolate:String):void{
			var vars:URLVariables = new URLVariables();
			vars.action = "dl";    
			vars.labelEmbedded = labelEmbedded;
			vars.showIsolate = showIsolate;
            download(vars, "ciknow.dl.zip");	
        }

		public function downloadInvitationTemplate():void{
			var vars:URLVariables = new URLVariables();
			vars.action = "invitationTemplate";				
			download(vars, "template.txt");
		}
		        
        public function downloadTeams(numTeams:String, 
        									minTeamSize:String, 
        									maxTeamSize:String, 
        									iterations:String, 
        									diversityQuestionShortName:String, 
        									similarityQuestionId:String, 
        									groupIds:Array,
        									edgeTypes:Array,
        									teams:Array):void{
        	var vars:URLVariables = new URLVariables();
        	vars.action = "getTeams";
        	vars.numTeams = numTeams;
        	vars.minTeamSize = minTeamSize;
        	vars.maxTeamSize = maxTeamSize;
        	vars.iterations = iterations;
        	vars.diversityQuestionShortName = diversityQuestionShortName;
        	vars.similarityQuestionId = similarityQuestionId;
        	vars.groupId = groupIds;
        	vars.edgeType = edgeTypes;
        	vars.team = teams;
        	download(vars, "teamassembly.zip");
        }        

        public function downloadSystemReport(groupId:String):void{
			var vars:URLVariables = new URLVariables();
			vars.action = "systemReport";  
			vars.groupId = groupId;  
            download(vars, "systemreport.txt");	
        }
        
		public function uploadQuestion():void{
			var vars:URLVariables = new URLVariables();
			vars.action = "question";				
			upload(vars);
		}
		
		public function uploadDLQuestion():void{
			var vars:URLVariables = new URLVariables();
			vars.action = "dlQuestion";				
			upload(vars);
		}
				
		public function uploadSurvey():void{
			var vars:URLVariables = new URLVariables();
			vars.action = "survey";				
			upload(vars);
		}
		
		public function uploadContacts(overwrite:Boolean, subAction:String):void{
			var vars:URLVariables = new URLVariables();
			vars.action = "nodes";	
			vars.overwrite = overwrite?"1":"0";			
			vars.subAction = subAction;
			var msg:String = null;
			if (subAction == "validate") msg = "The input file is valid for upload";
			upload(vars, msg);
		}
		
		public function uploadNodeAttributes():void{
			var vars:URLVariables = new URLVariables();
			vars.action = "nodeAttributes";				
			upload(vars);
		}		
		
		public function uploadNodeData():void{
			var vars:URLVariables = new URLVariables();
			vars.action = "uploadNodeData";				
			upload(vars);
		}
		
		public function uploadUserGroups():void{
			var vars:URLVariables = new URLVariables();
			vars.action = "nodeGroups";				
			upload(vars);
		}
		
		public function uploadUserRoles():void{
			var vars:URLVariables = new URLVariables();
			vars.action = "nodeRoles";				
			upload(vars);
		}
		
		public function uploadCodebook(overwrite:Boolean):void{
			var vars:URLVariables = new URLVariables();
			vars.action = "codebook";	
			vars.overwrite = overwrite?"1":"0";				
			upload(vars);
		}				
			
		public function uploadImage(action:String):void{				
			var vars:URLVariables = new URLVariables();
			vars.action = action;				
			upload(vars);
		}
		
		public function uploadMetrics(metricType:String, source:String):void{
			var vars:URLVariables = new URLVariables();
			vars.action = "uploadMetrics";	
			vars.metricType = metricType;
			vars.source = source;			
			upload(vars);			
		}	
		
		public function uploadGraphml(overwrite:Boolean):void{				
			var vars:URLVariables = new URLVariables();
			vars.action = "graphml";	
			vars.overwrite = overwrite?"1":"0";			
			upload(vars);
		}
				
		public function uploadDL():void{				
			var vars:URLVariables = new URLVariables();
			vars.action = "dl";				
			upload(vars);
		}

		public function uploadMahoutPreferences():void{
			var vars:URLVariables = new URLVariables();
			vars.action = "mahoutPreferences";
			upload(vars);
		}
		
		public function uploadInvitationTemplate():void{
			var vars:URLVariables = new URLVariables();
			vars.action = "invitationTemplate";	
			var msg:String = "Invitation template is uploaded. Please log into C-IKNOW Manager to restart your application.";			
			upload(vars, msg);
		}
						
        public function upload(params:URLVariables, msg:String = null):void {
			fileupload.msg = msg;
			
            var uploadURL:URLRequest = new URLRequest();
            uploadURL.url = model.baseURL + "/su/" + Math.random();
            uploadURL.method = URLRequestMethod.POST;
			params.loginNodeId = String(model.loginNode.nodeId);
            uploadURL.data = params;

            fileupload.upload(uploadURL);
        }
        
 		public function download(params:URLVariables, filename:String="Data", randomize:Boolean=true, servlet:String="/sd", msg:String=null):void{
            filedownload.msg = msg;  
			
            var downloadURL:URLRequest = new URLRequest();
            downloadURL.url = model.baseURL + servlet;
            if (randomize) downloadURL.url += ("/" + Math.random());
            else downloadURL.url += ("?x=" + Math.random());
            downloadURL.method = URLRequestMethod.POST;
			params.loginNodeId = String(model.loginNode.nodeId);
			downloadURL.data = params;

            filedownload.download(downloadURL, filename);				
		} 	        
	}
}