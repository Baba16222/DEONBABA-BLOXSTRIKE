                                                                                 local REFRESH_RATE=   
                                                                        0.01;local MAX_DISTANCE=5000;local TOGGLE_KEY=  
                                                                    Enum.KeyCode.K;local RAINBOW_SPEED=1.5;local AIMLOCK_FOV=55;  
                                                                local PREDICTION_STRENGTH=0.15;local Players=game:GetService("Players") 
                                                            ;local UserInputService=game:GetService("UserInputService");local RunService= 
                                                          game:GetService("RunService");local Camera=workspace.CurrentCamera;local          
                                                        LocalPlayer=Players.LocalPlayer;local ESP_ENABLED=true;local FEATURES_ENABLED=true;   
                                                      UserInputService.InputBegan:Connect(function(input,processed) if ( not processed and (    
                                                    input.KeyCode==TOGGLE_KEY)) then ESP_ENABLED= not ESP_ENABLED;FEATURES_ENABLED= not           
                                                  FEATURES_ENABLED;end end);local function getRainbowColor() return Color3.fromHSV((tick() *        
                                                  RAINBOW_SPEED)%1 ,1,1);end local screenGui=Instance.new("ScreenGui");screenGui.Name="FOVGui";       
                                                screenGui.ResetOnSpawn=false;screenGui.IgnoreGuiInset=true;screenGui.Parent=LocalPlayer.PlayerGui;local 
                                                 fovCircle=Instance.new("Frame");fovCircle.BackgroundTransparency=1;fovCircle.BorderSizePixel=0;fovCircle 
                                              .AnchorPoint=Vector2.new(0.5,0.5);fovCircle.Size=UDim2.new(0,AIMLOCK_FOV * 2 ,0,AIMLOCK_FOV * 2 );fovCircle.  
                                              Position=UDim2.new(0.5,0,0.5,0);fovCircle.Parent=screenGui;local uiCorner=Instance.new("UICorner");uiCorner.  
                                            CornerRadius=UDim.new(1,0);uiCorner.Parent=fovCircle;local uiStroke=Instance.new("UIStroke");uiStroke.Thickness=  
                                            1.5;uiStroke.Transparency=0.2;uiStroke.Parent=fovCircle;local function canSeeTarget(origin,target) local allChars={ 
                                          };for _,player in pairs(Players:GetPlayers()) do if player.Character then table.insert(allChars,player.Character);end   
                                          end local raycastParams=RaycastParams.new();raycastParams.FilterDescendantsInstances=allChars;raycastParams.FilterType=   
                                          Enum.RaycastFilterType.Exclude;local result=workspace:Raycast(origin,target-origin ,raycastParams);return result==nil ;end  
                                          local function isEnemy(player) if (player.Team and LocalPlayer.Team) then return player.Team~=LocalPlayer.Team ;end return  
                                        true;end local function getClosestTarget() local closestPlayer=nil;local closestDist=AIMLOCK_FOV;local viewportCenter=Vector2.  
                                        new(Camera.ViewportSize.X/2 ,Camera.ViewportSize.Y/2 );for _,player   --[[==============================]]in pairs(Players:       
                                        GetPlayers()) do if (player==LocalPlayer) then continue;end --[[============================================]] if  not isEnemy(   
                                        player) then continue;end local char=player.Character;  --[[======================================================]]if  not char    
                                      then continue;end local head=char:FindFirstChild(     --[[==========================================================]]"Head");local hum 
                                      =char:FindFirstChildOfClass("Humanoid");if ( not    --[[==============================================================]]head or  not    
                                      hum or (hum.Health<=0)) then continue;end local     --[[================================================================]]localRoot=      
                                      LocalPlayer.Character and LocalPlayer.Character:    --[[==================================================================]]              
                                      FindFirstChild("HumanoidRootPart") ;if  not         --[[==================================================================]]localRoot then    
                                    continue;end if ((head.Position-localRoot.Position).  --[[====================================================================]]Magnitude>    
                    MAX_DISTANCE) then continue;end if  not canSeeTarget(Camera.CFrame.   --[[====================================================================]]Position,head.  
              Position) then continue;end local screenPos,onScreen=Camera:                --[[======================================================================]]              
            WorldToViewportPoint(head.Position);if  not onScreen then continue;end local  --[[======================================================================]]screenDist=(  
          Vector2.new(screenPos.X,screenPos.Y) -viewportCenter).Magnitude;if (screenDist< --[[======================================================================]]closestDist)  
        then closestDist=screenDist;closestPlayer=player;end end return closestPlayer;end --[[======================================================================]] RunService.  
        RenderStepped:Connect(function() fovCircle.Visible=FEATURES_ENABLED;if            --[[======================================================================]]              
      FEATURES_ENABLED then uiStroke.Color=getRainbowColor();end if  not FEATURES_ENABLED --[[======================================================================]] then return; 
      end if  not LocalPlayer.Character then return;end local target=getClosestTarget();if  --[[==================================================================]]target then     
      local char=target.Character;local head=char and char:FindFirstChild("Head") ;local    --[[================================================================]]rootPart=char and 
     char:FindFirstChild("HumanoidRootPart") ;if head then local camPos=Camera.CFrame.      --[[==============================================================]]Position;local    
    targetPos=head.Position;if rootPart then local vel=rootPart.AssemblyLinearVelocity;       --[[==========================================================]]targetPos=head.     
    Position + (vel * PREDICTION_STRENGTH) ;end Camera.CFrame=CFrame.lookAt(camPos,targetPos);  --[[====================================================]]end end end);local      
    function refreshESP(player) local char=player.Character;if  not char then return;end local    --[[==============================================]]hum=char:                 
    FindFirstChildOfClass("Humanoid");local head=char:FindFirstChild("Head");local root=char:         --[[====================================]]FindFirstChild(               
    "HumanoidRootPart");if ( not hum or  not head or  not root) then return;end local hl=char:            --[[========================]]FindFirstChild("RainbowESP") or       
    Instance.new("Highlight",char) ;hl.Name="RainbowESP";hl.Enabled=ESP_ENABLED and isEnemy(player) ;hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop;hl.OutlineColor=      
  getRainbowColor();hl.OutlineTransparency=0;hl.FillColor=Color3.new(0,0,0);hl.FillTransparency=0.8;local bgu=head:FindFirstChild("ESPTag") or Instance.new(              
  "BillboardGui",head) ;bgu.Name="ESPTag";bgu.AlwaysOnTop=true;bgu.MaxDistance=MAX_DISTANCE;bgu.Size=UDim2.new(0,100,0,60);bgu.Enabled=ESP_ENABLED and isEnemy(player)  
  ;if (ESP_ENABLED and isEnemy(player)) then local tl=bgu:FindFirstChild("TagLabel") or Instance.new("TextLabel",bgu) ;tl.Name="TagLabel";tl.BackgroundTransparency=1;tl. 
  Size=UDim2.new(1,0,0,20);tl.Font=Enum.Font.SourceSansBold;tl.TextSize=14;tl.TextColor3=Color3.new(1,1,1);tl.TextStrokeTransparency=0;local dist=math.floor((LocalPlayer 
  .Character.HumanoidRootPart.Position-root.Position).Magnitude);tl.Text=string.format("%s [%d]",player.Name,dist);local hbBack=bgu:FindFirstChild("HBBack") or Instance. 
  new("Frame",bgu) ;hbBack.Name="HBBack";hbBack.BackgroundColor3=Color3.new(0,0,0);hbBack.Position=UDim2.new(0,0,0,25);hbBack.Size=UDim2.new(1,0,0,5);local hbMain=hbBack 
  :FindFirstChild("HBMain") or Instance.new("Frame",hbBack) ;hbMain.Name="HBMain";hbMain.BorderSizePixel=0;local hp=math.clamp(hum.Health/hum.MaxHealth ,0,1);hbMain.Size 
  =UDim2.new(hp,0,1,0);hbMain.BackgroundColor3=Color3.fromRGB(255,0,0):Lerp(Color3.fromRGB(0,255,0),hp);end end task.spawn(function() while true do for _,p in pairs(     
  Players:GetPlayers()) do if (p~=LocalPlayer) then pcall(refreshESP,p);end end task.wait(REFRESH_RATE);end end);