package ${basepackage}.utils;

import java.beans.PropertyDescriptor;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Set;

import javax.persistence.OneToMany;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.JoinType;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.persistence.criteria.SetJoin;

import org.springframework.data.jpa.domain.Specification;


/**
 * @文件名 DynamicSpecifications.java
 * @作者   paul
 * @创建日期 2013-12-17
 * @版本 V 1.0
 */
public class DynamicSpecifications {
	public static <T> Specification<T> bySearchFilter(final Collection<SearchFilter> filters, final Class<T> clazz) {
		return new Specification<T>() {
			@SuppressWarnings({ "rawtypes", "unchecked" })
			@Override
			public Predicate toPredicate(Root<T> root, CriteriaQuery<?> query, CriteriaBuilder builder) {
				if (ObjectUtils.isNotEmpty(filters)) {
					List<Predicate> predicates = new ArrayList<Predicate>();
					Class entyClass=root.getJavaType();
					for (SearchFilter filter : filters) {
						// nested path translate, 如Task的名为"user.name"的filedName, 转换为Task.user.name属性
						String[] names = filter.fieldName.split(".");
						SetJoin join = null;
						Path expression = root.get(names[0]);
						try {
							PropertyDescriptor descriptor = new PropertyDescriptor(names[0], entyClass);
							Method readMethod=descriptor.getReadMethod();
							Class returnTypeClass = readMethod.getReturnType();
							if(readMethod.getAnnotation(OneToMany.class) !=null&&returnTypeClass.isAssignableFrom(Set.class)){
								Class genericType= GenericsUtils.getMethodGenericReturnType(readMethod);
								join = root.join(root.getModel().getSet(names[0], genericType),JoinType.LEFT);
							}
						} catch (Exception e) {
							e.printStackTrace();
						}
						for (int i = 1; i < names.length; i++) {
							if(join!=null){
								expression = join.get(names[i]);
								join=null;
							}else{
								expression = expression.get(names[i]);
							}
						}
						switch (filter.operator) {
						case EQ:
							if("null".equals(filter.value.toString())){
								predicates.add(builder.isNull(expression));
							}else{
								predicates.add(builder.equal(expression, filter.value));
							}
							break;
						case NEQ:
							if("null".equals(filter.value.toString())){
								predicates.add(builder.isNotNull(expression));
							}else{
								predicates.add(builder.notEqual(expression, filter.value));
							}
							break;
						case LIKE:
							predicates.add(builder.like(expression, "%" + filter.value + "%"));
							break;
						case GT:
							predicates.add(builder.greaterThan(expression, (Comparable) filter.value));
							break;
						case LT:
							predicates.add(builder.lessThan(expression, (Comparable) filter.value));
							break;
						case GTE:
							predicates.add(builder.greaterThanOrEqualTo(expression, (Comparable) filter.value));
							break;
						case LTE:
							predicates.add(builder.lessThanOrEqualTo(expression, (Comparable) filter.value));
							break;
						case IN:
							predicates.add(builder.in(expression).in(filter.value));
							break;
						case NOTIN:
							predicates.add(builder.not(builder.in(expression).in(filter.value)));
						}
					}
					// 将所有条件用 and 联合起来
					if (predicates.size() > 0) {
						return builder.and(predicates.toArray(new Predicate[predicates.size()]));
					}
				}
				return builder.conjunction();
			}
		};
	}
}
