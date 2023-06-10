package dao;

import util.DaoHelper;
import vo.Lesson;

public class GroupeLessonDao {

	private GroupeLessonDao() {}
	
	public static GroupeLessonDao instance = new GroupeLessonDao();
	public static GroupeLessonDao getinstance() {
		return instance;
	}
	
	public void insertGroupLesson(Lesson lesson) {
		DaoHelper.update("groupLessonDao.insertGroupLesson", 
															 lesson.getName(),
															 lesson.getType(),
															 lesson.getQuota(),
															 lesson.getDescription(),
															 lesson.getUser().getId(),
															 lesson.getTime(),
															 lesson.getGym().getNo());
	}
	
	
//	public Lesson getGroupLessons() {
//		return DaoHelper.selectOne("groupLessonDao.getGroupLessons", rs->{
//			Lesson groupLesson = new Lesson();
//			groupLesson.setNo(rs.getInt("lesson_no"));
//		});
//	}
}
