// Copyright 2020-2022 The MathWorks, Inc.
// Common copy functions for yolov8_msgs/Pose2D
#ifdef _MSC_VER
#pragma warning(push)
#pragma warning(disable : 4100)
#pragma warning(disable : 4265)
#pragma warning(disable : 4456)
#pragma warning(disable : 4458)
#pragma warning(disable : 4946)
#pragma warning(disable : 4244)
#else
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wpedantic"
#pragma GCC diagnostic ignored "-Wunused-local-typedefs"
#pragma GCC diagnostic ignored "-Wredundant-decls"
#pragma GCC diagnostic ignored "-Wnon-virtual-dtor"
#pragma GCC diagnostic ignored "-Wdelete-non-virtual-dtor"
#pragma GCC diagnostic ignored "-Wunused-parameter"
#pragma GCC diagnostic ignored "-Wunused-variable"
#pragma GCC diagnostic ignored "-Wshadow"
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#endif //_MSC_VER
#include "rclcpp/rclcpp.hpp"
#include "yolov8_msgs/msg/pose2_d.hpp"
#include "visibility_control.h"
#include "class_loader/multi_library_class_loader.hpp"
#include "ROS2PubSubTemplates.hpp"
class YOLOV8_MSGS_EXPORT ros2_yolov8_msgs_msg_Pose2D_common : public MATLABROS2MsgInterface<yolov8_msgs::msg::Pose2D> {
  public:
    virtual ~ros2_yolov8_msgs_msg_Pose2D_common(){}
    virtual void copy_from_struct(yolov8_msgs::msg::Pose2D* msg, const matlab::data::Struct& arr, MultiLibLoader loader); 
    //----------------------------------------------------------------------------
    virtual MDArray_T get_arr(MDFactory_T& factory, const yolov8_msgs::msg::Pose2D* msg, MultiLibLoader loader, size_t size = 1);
};
  void ros2_yolov8_msgs_msg_Pose2D_common::copy_from_struct(yolov8_msgs::msg::Pose2D* msg, const matlab::data::Struct& arr,
               MultiLibLoader loader) {
    try {
        //position
        const matlab::data::StructArray position_arr = arr["position"];
        auto msgClassPtr_position = getCommonObject<yolov8_msgs::msg::Point2D>("ros2_yolov8_msgs_msg_Point2D_common",loader);
        msgClassPtr_position->copy_from_struct(&msg->position,position_arr[0],loader);
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'position' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'position' is wrong type; expected a struct.");
    }
    try {
        //theta
        const matlab::data::TypedArray<double> theta_arr = arr["theta"];
        msg->theta = theta_arr[0];
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'theta' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'theta' is wrong type; expected a double.");
    }
  }
  //----------------------------------------------------------------------------
  MDArray_T ros2_yolov8_msgs_msg_Pose2D_common::get_arr(MDFactory_T& factory, const yolov8_msgs::msg::Pose2D* msg,
       MultiLibLoader loader, size_t size) {
    auto outArray = factory.createStructArray({size,1},{"MessageType","position","theta"});
    for(size_t ctr = 0; ctr < size; ctr++){
    outArray[ctr]["MessageType"] = factory.createCharArray("yolov8_msgs/Pose2D");
    // position
    auto currentElement_position = (msg + ctr)->position;
    auto msgClassPtr_position = getCommonObject<yolov8_msgs::msg::Point2D>("ros2_yolov8_msgs_msg_Point2D_common",loader);
    outArray[ctr]["position"] = msgClassPtr_position->get_arr(factory, &currentElement_position, loader);
    // theta
    auto currentElement_theta = (msg + ctr)->theta;
    outArray[ctr]["theta"] = factory.createScalar(currentElement_theta);
    }
    return std::move(outArray);
  } 
class YOLOV8_MSGS_EXPORT ros2_yolov8_msgs_Pose2D_message : public ROS2MsgElementInterfaceFactory {
  public:
    virtual ~ros2_yolov8_msgs_Pose2D_message(){}
    virtual std::shared_ptr<MATLABPublisherInterface> generatePublisherInterface(ElementType /*type*/);
    virtual std::shared_ptr<MATLABSubscriberInterface> generateSubscriberInterface(ElementType /*type*/);
    virtual std::shared_ptr<void> generateCppMessage(ElementType /*type*/, const matlab::data::StructArray& /* arr */, MultiLibLoader /* loader */, std::map<std::string,std::shared_ptr<MATLABROS2MsgInterfaceBase>>* /*commonObjMap*/);
    virtual matlab::data::StructArray generateMLMessage(ElementType  /*type*/ ,void*  /* msg */, MultiLibLoader /* loader */ , std::map<std::string,std::shared_ptr<MATLABROS2MsgInterfaceBase>>* /*commonObjMap*/);
};  
  std::shared_ptr<MATLABPublisherInterface> 
          ros2_yolov8_msgs_Pose2D_message::generatePublisherInterface(ElementType /*type*/){
    return std::make_shared<ROS2PublisherImpl<yolov8_msgs::msg::Pose2D,ros2_yolov8_msgs_msg_Pose2D_common>>();
  }
  std::shared_ptr<MATLABSubscriberInterface> 
         ros2_yolov8_msgs_Pose2D_message::generateSubscriberInterface(ElementType /*type*/){
    return std::make_shared<ROS2SubscriberImpl<yolov8_msgs::msg::Pose2D,ros2_yolov8_msgs_msg_Pose2D_common>>();
  }
  std::shared_ptr<void> ros2_yolov8_msgs_Pose2D_message::generateCppMessage(ElementType /*type*/, 
                                           const matlab::data::StructArray& arr,
                                           MultiLibLoader loader,
                                           std::map<std::string,std::shared_ptr<MATLABROS2MsgInterfaceBase>>* commonObjMap){
    auto msg = std::make_shared<yolov8_msgs::msg::Pose2D>();
    ros2_yolov8_msgs_msg_Pose2D_common commonObj;
    commonObj.mCommonObjMap = commonObjMap;
    commonObj.copy_from_struct(msg.get(), arr[0], loader);
    return msg;
  }
  matlab::data::StructArray ros2_yolov8_msgs_Pose2D_message::generateMLMessage(ElementType  /*type*/ ,
                                                    void*  msg ,
                                                    MultiLibLoader  loader ,
                                                    std::map<std::string,std::shared_ptr<MATLABROS2MsgInterfaceBase>>*  commonObjMap ){
    ros2_yolov8_msgs_msg_Pose2D_common commonObj;	
    commonObj.mCommonObjMap = commonObjMap;	
    MDFactory_T factory;
    return commonObj.get_arr(factory, (yolov8_msgs::msg::Pose2D*)msg, loader);			
 }
#include "class_loader/register_macro.hpp"
// Register the component with class_loader.
// This acts as a sort of entry point, allowing the component to be discoverable when its library
// is being loaded into a running process.
CLASS_LOADER_REGISTER_CLASS(ros2_yolov8_msgs_msg_Pose2D_common, MATLABROS2MsgInterface<yolov8_msgs::msg::Pose2D>)
CLASS_LOADER_REGISTER_CLASS(ros2_yolov8_msgs_Pose2D_message, ROS2MsgElementInterfaceFactory)
#ifdef _MSC_VER
#pragma warning(pop)
#else
#pragma GCC diagnostic pop
#endif //_MSC_VER